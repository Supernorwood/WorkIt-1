package test;

import static org.junit.Assert.assertEquals;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import entities.Job;
import entities.Skill;

public class JobTest {
	private EntityManagerFactory emf;
	private EntityManager em;
	
	
	@Before
	public void set_up() {
		emf = Persistence.createEntityManagerFactory("YourPU");
		em = emf.createEntityManager();
//		j = em.find(Job.class, 1);
	}
	
	@After
	public void tear_down() {
		em.close();
		emf.close();
	}
	
	@Test
	public void smoke_test() {
		boolean test = true;
		assertEquals(true, test);
	}
	
	@Test
	public void test_job_to_database() {
		Job j = em.find(Job.class, 1);
		assertEquals("Developer II", j.getTitle());
	}
	
	
//	@Test
//	public void test_job_to_user_id() {
//		Job j = em.find(Job.class, 104);
//		assertEquals("Literally just stand there", j.getTitle());
//		assertEquals("Lamps Inc", j.getCompany());
//		assertEquals("a", j.getUser().getFirstName());
//		
//	}
	
	@Test
	public void test_job_to_contact() {
		//test SELECT c FROM Contact c WHERE c.id = 1 something something 
	}
	
	@Test
	public void test_job_to_address() {
		//test SELECT a from ADDRESS WHERE j.id = something something
		Job j = em.find(Job.class, 1);
		assertEquals("Paramus", j.getAddress().getCity());
	}
	
	@Test
	public void test_job_to_skills() {
		Job j = em.find(Job.class, 1);
		List<Skill> skills = j.getJobSkills();
		assertEquals("NCARB", skills.get(0).getSkill());
	}
}




//need to create a user to test for in db
//do assertEquals for the entity stuff in the entity that aren't relationships
//write a separate method that tests for each relationship
//user2 = test for job
