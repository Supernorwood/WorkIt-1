package data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class SkillDAOImpl implements SkillDAO {

	@PersistenceContext
	private EntityManager em;
	
	@Override
	public Boolean destroySkill(int uid, int sid) {
		String query = "DELETE FROM user_skills WHERE user_id = :uid AND skill_id = :sid";
		long numModified = em.createNativeQuery(query).setParameter("uid", uid).setParameter("sid", sid).executeUpdate();
		return numModified > 0;
	}
	
	@Override
	public Boolean destroyJobSkill(int jid, int sid) {
		String query = "DELETE FROM job_skills WHERE job_id = :uid AND skill_id = :sid";
		long numModified = em.createNativeQuery(query).setParameter("jid", jid).setParameter("sid", sid).executeUpdate();
		return numModified > 0;
	}


}
