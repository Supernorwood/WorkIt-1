package test;

import static org.junit.Assert.assertEquals;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import entities.Address;
import entities.Contact;
import entities.User;


public class ContactTest {
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
	public void test_connection() {
		Contact c = em.find(Contact.class, 1);
		assertEquals("Benji", c.getFirstName());
	}
	
	@Test
	public void test_contact_has_user() {
		Contact c = em.find(Contact.class, 1);
		User u = c.getUser();
		assertEquals("Jen", u.getFirstName());
	}
	
	@Test
	public void test_contact_has_address() {
		Contact c = em.find(Contact.class, 1);
		Address a = c.getAddress();
		assertEquals("Boise", a.getCity());
	}
	
}
