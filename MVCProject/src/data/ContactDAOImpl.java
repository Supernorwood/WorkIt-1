package data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;

import entities.Contact;
import entities.User;

@Transactional
@Repository
public class ContactDAOImpl implements ContactDAO {

	@PersistenceContext
	private EntityManager em;
	
	@Override
	public List<Contact> getAllUserContacts(int userId) {
		String query = "SELECT c FROM Contact c WHERE c.user.id = :userId";
		List<Contact> userContacts = em.createQuery(query, Contact.class).setParameter("userId", userId).getResultList();
		return userContacts;
	}

	@Override
	public Contact getContactById(int contactId) {
		return em.find(Contact.class, contactId);
	}

	@Override
	public Contact addContact(int userId, String contactJson) {
		ObjectMapper mapper = new ObjectMapper();
		Contact newContact = null;
		
		try {
			newContact = mapper.readValue(contactJson, Contact.class);
			newContact.setUser(em.find(User.class, userId));
			em.persist(newContact);
			em.flush();
			return newContact;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

	@Override
	public Contact updateContact(int userId, int contactId, String contactJson) {
		ObjectMapper mapper = new ObjectMapper();
		Contact managedContact = em.find(Contact.class, contactId);
		Contact updateContact = null;
		try {
			updateContact = mapper.readValue(contactJson, Contact.class);
			System.out.println(updateContact.getLastContactDate());
			managedContact.setFirstName(updateContact.getFirstName());
			managedContact.setLastName(updateContact.getLastName());
			managedContact.setTitle(updateContact.getTitle());
			managedContact.setCompany(updateContact.getCompany());
			managedContact.setEmail(updateContact.getEmail());
			managedContact.setPhone(updateContact.getPhone());
			if (managedContact.getAddress()!=null) {
				managedContact.getAddress().setStreet(updateContact.getAddress().getStreet());
				managedContact.getAddress().setCity(updateContact.getAddress().getCity());
				managedContact.getAddress().setState(updateContact.getAddress().getState());
				managedContact.getAddress().setZip(updateContact.getAddress().getZip());
				managedContact.getAddress().setCountry(updateContact.getAddress().getCountry());
			}
			else {
				managedContact.setAddress(updateContact.getAddress());
			}
			managedContact.setContactCount(updateContact.getContactCount());
			managedContact.setLastContactDate(updateContact.getLastContactDate());
			managedContact.setCreateDate(updateContact.getCreateDate());
			managedContact.setLastUpdate(updateContact.getLastUpdate());
			return managedContact;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Boolean destroyContact(int userId, int contactId) {
		String query = "DELETE FROM Contact WHERE id = :contactId";
		em.createQuery(query).setParameter("contactId", contactId).executeUpdate();
		return !em.contains(em.find(Contact.class, contactId));
	}

}
