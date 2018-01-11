package data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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
			List<User> users = em.createQuery(queryString, User.class)
								.setParameter("email", u.getEmail())
								.getResultList();
			if(users.size() > 0) {
				
					User managedUser = users.get(0);
					if(encoder.matches(u.getPassword(), managedUser.getPassword())) {
						return managedUser;
					}
				}
			return null;
		}
	
	
}
