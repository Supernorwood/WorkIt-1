package test;

import static org.junit.Assert.assertEquals;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import entities.User;

public class UserTest {
	private EntityManagerFactory emf;
	private EntityManager em;
	
	
	@Before
	public void set_up() {
		emf = Persistence.createEntityManagerFactory("YourPU");
		em = emf.createEntityManager();
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
		User u = em.find(User.class, 1);
		assertEquals("Vivian", u.getFirstName());//need to create a user to test for in db
		
		
		//do assertEquals for the entity stuff in the entity that aren't relationships
		//write a separate method that tests for each relationship
		//user2 = test for job
	}
	
	
}
