package test;

import static org.junit.Assert.assertEquals;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import entities.Job;

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
	public void userScalarTypes() {
		Job j = em.find(Job.class, 1);
		assertEquals("Developer II", j.getTitle()); //title depends on how it's named in the entity
	}
	
	
	@Test
	public void test_job_to_user_id() {
		
	}
	
}




//need to create a user to test for in db
//do assertEquals for the entity stuff in the entity that aren't relationships
//write a separate method that tests for each relationship
//user2 = test for job
