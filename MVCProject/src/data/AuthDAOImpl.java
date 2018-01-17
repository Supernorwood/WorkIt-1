package data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;

import entities.Skill;
import entities.User;

@Transactional
@Repository
public class AuthDAOImpl implements AuthDAO {

	@PersistenceContext
	private EntityManager em;

	@Autowired
	private PasswordEncoder encoder;

	@Override
	public User register(User u) {
		String passwordSha = encoder.encode(u.getPassword());
		u.setPassword(passwordSha);
		em.persist(u);
		em.flush();
		return u;
	}

	@Override
	public User login(User u) {
		String queryString = "Select u from User u Where u.email = :email";
		List<User> users = em.createQuery(queryString, User.class).setParameter("email", u.getEmail()).getResultList();
		if (users.size() > 0) {
			User managedUser = users.get(0);
			if (encoder.matches(u.getPassword(), managedUser.getPassword())) {
				return managedUser;
			}
		}
		return null;
	}

	@Override
	public User authenticateUser(User user) throws NoResultException {
		// find the User by username/email (a unique field)
		String query = "SELECT u FROM User u WHERE u.email = :email";
		User managedUser = em.createQuery(query, User.class).setParameter("email", user.getEmail()).getSingleResult();
		if (encoder.matches(user.getPassword(), managedUser.getPassword())) {
			return managedUser;
		}
		return null;
	}

	@Override
	public User updateUser(int userId, String userJson) {
		ObjectMapper mapper = new ObjectMapper();
		User updateUser = null;
		User managedUser = em.find(User.class, userId);
		
		try {
			updateUser = mapper.readValue(userJson, User.class);
			List<Skill> updateSkills = updateUser.getUserSkills();
			List<Skill> persistedUpdateSkills = new ArrayList<>();
			
			for (Skill updateSkill : updateSkills) {
				int updateSkillId;
				try {
					updateSkillId = updateSkill.getId();
				}
				catch (NullPointerException npe) {
					updateSkillId = 0;
				}
				if (updateSkillId == 0) {
					Skill persistingSkill = new Skill();
					persistingSkill.setSkill(updateSkill.getSkill());
					em.persist(persistingSkill);
					em.flush();
					persistedUpdateSkills.add(persistingSkill);
					String query = "INSERT INTO user_skills (user_id, skill_id) VALUES (:userId, :skillId)";
					em.createNativeQuery(query).setParameter("userId", updateUser.getId()).setParameter("skillId", persistingSkill.getId()).executeUpdate();
				}
			}
			if (persistedUpdateSkills.size() > 0) {
				managedUser.setUserSkills(persistedUpdateSkills);
			}
			managedUser.setFirstName(updateUser.getFirstName());
			managedUser.setLastName(updateUser.getLastName());
			managedUser.setEmail(updateUser.getEmail());			
			return managedUser;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Boolean destroyUser(int userId) {
		String query = "DELETE FROM Job WHERE user.id = :userId";
		em.createQuery(query).setParameter("userId", userId).executeUpdate();
		query = "DELETE FROM User WHERE id = :userId";
		em.createQuery(query).setParameter("userId", userId).executeUpdate();
		return em.find(User.class, userId) == null;
	}

	@Override
	public User getUserById(int userId) {
		return em.find(User.class, userId);
	}
	
	

}
