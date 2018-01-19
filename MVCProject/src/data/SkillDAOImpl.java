package data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;

import entities.Job;
import entities.Skill;
import entities.User;

@Repository
@Transactional
public class SkillDAOImpl implements SkillDAO {

	@PersistenceContext
	private EntityManager em;
	
	@Override
	public Boolean destroySkill(int uid, int sid) {
		String query = "DELETE FROM Skill WHERE id = :sid";
		em.createQuery(query).setParameter("sid", sid).executeUpdate();
		return !em.contains(em.find(Skill.class, sid));
	}
	
	@Override
	public Boolean destroyJobSkill(int jid, int sid) {
		String query = "DELETE FROM job_skills WHERE job_id = :uid AND skill_id = :sid";
		long numModified = em.createNativeQuery(query).setParameter("jid", jid).setParameter("sid", sid).executeUpdate();
		return numModified > 0;
	}

	@Override
	public Skill addSkill(int uid, String json) {
		ObjectMapper mapper = new ObjectMapper();
		Skill newSkill = null;
		try {
			newSkill = mapper.readValue(json, Skill.class);
			User u = em.find(User.class, uid);
			newSkill.setSkillUser(u);
			em.persist(newSkill);
			em.flush();
			return newSkill;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Skill> getAllSkills(int uid) {
		String query = "SELECT s from Skill s WHERE s.user.id = :uid";
		List<Skill> skills = em.createQuery(query, Skill.class)
				.setParameter("uid", uid)
				.getResultList();
		return skills;
	}


}
