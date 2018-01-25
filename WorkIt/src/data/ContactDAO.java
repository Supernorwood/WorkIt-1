package data;

import java.util.List;

import entities.Contact;

public interface ContactDAO {
	
	public List<Contact> getAllUserContacts(int userId);
	
	public Contact getContactById(int contactId);
	
	public Contact addContact(int userId, String contactJson);
	
	public Contact updateContact(int userId, int contactId, String contactJson);
	
	public Boolean destroyContact(int userId, int contactId);

}
