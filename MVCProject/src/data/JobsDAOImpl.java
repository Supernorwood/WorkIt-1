package data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;

import entities.Contact;
import entities.Job;
import entities.User;

	@Transactional
	@Repository
	public class JobsDAOImpl implements JobsDAO {

		@PersistenceContext
		private EntityManager em;
		
		@Override
		public List<Job> getAllJobs(int uid) {
			String query = "SELECT j from Job j WHERE j.user.id = :uid"; 
			List<Job> jobs = em.createQuery(query, Job.class)
					.setParameter("uid", uid)
					.getResultList();
			return jobs;
		}

		@Override
		public Job getJobById(int uid, int jid) {
			Job job = em.find(Job.class, jid);
			if(job == null || job.getUser().getId() != uid) {
				return null;
			}
			return job;
		}

		@Override
		public Job addNewJob(int uid, String json) {
			System.out.println(json);
			ObjectMapper mapper = new ObjectMapper();
			Job newJob = null;
			try {
				newJob = mapper.readValue(json, Job.class);
				User u = em.find(User.class, uid);
				newJob.setUser(u);
				em.persist(newJob);
				em.flush();
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			return newJob;
		}

		//May need to add additional fields
		@Override
		public Job updateJob(int uid, int jid, String json) {
			ObjectMapper mapper = new ObjectMapper();
			Job job = null;
			Job ogJob = null;
			try {
				job = mapper.readValue(json, Job.class);
				ogJob = em.find(Job.class, jid);
				ogJob.setTitle(job.getTitle());
				ogJob.setCompany(job.getCompany());
//				ogJob.setNotes(job.getNotes());
				if (ogJob.getAddress()!=null) {
					ogJob.getAddress().setStreet(job.getAddress().getStreet());
					ogJob.getAddress().setCity(job.getAddress().getCity());
					ogJob.getAddress().setState(job.getAddress().getState());
					ogJob.getAddress().setZip(job.getAddress().getZip());
					ogJob.getAddress().setCountry(job.getAddress().getCountry());
				}
				else {
					ogJob.setAddress(job.getAddress());
				}
				ogJob.setLink(job.getLink());
				ogJob.setActive(job.getActive());
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			return ogJob;
		}

		@Override
		public Boolean destroyJob(int uid, int jid) {
			String query = "DELETE FROM Job WHERE id = :jid";
			em.createQuery(query).setParameter("jid", jid).executeUpdate();
			return !em.contains(em.find(Job.class, jid));
			
//			Job job = em.find(Job.class, jid);
//			try {
//				em.remove(job);
//				return true;
//			}
//			catch (Exception e) {
//				return false;
//			}
		}



}
