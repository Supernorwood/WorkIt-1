package data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;

import entities.Job;

	@Transactional
	@Repository
	public class JobsDAOImpl implements JobsDAO {

		@PersistenceContext
		private EntityManager em;
		
		@Override
		public List<Job> getAllJobs() {
			String query = "SELECT j from Job j"; 
			List<Job> jobs = em.createQuery(query, Job.class)
					.getResultList();
			return jobs;
		}

		@Override
		public Job getJobById(int id) {
			Job job = em.find(Job.class, id);
			return job;
		}

		@Override
		public Job addNewJob(String json) {
			ObjectMapper mapper = new ObjectMapper();
			Job newJob = null;
			try {
				newJob = mapper.readValue(json, Job.class);
				em.persist(newJob);
				em.flush();
				return newJob;
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			return null;
		}

		//May need to add additional fields
		@Override
		public Job updateJob(int id, String json) {
			ObjectMapper mapper = new ObjectMapper();
			Job job = null;
			Job ogJob = null;
			try {
				job = mapper.readValue(json, Job.class);
				ogJob = em.find(Job.class, id);
				ogJob.setTitle(job.getTitle());
				ogJob.setCompany(job.getCompany());
				ogJob.setLink(job.getLink());
				ogJob.setActive(job.getActive());
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			return ogJob;
		}

		@Override
		public Boolean destroyJob(int id) {
			Job job = em.find(Job.class, id);
			try {
				em.remove(job);
				return true;
			}
			catch (Exception e) {
				return false;
			}
		}



}
