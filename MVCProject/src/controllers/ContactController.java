package controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import data.ContactDAO;
import entities.Contact;

@RestController
public class ContactController {

	@Autowired
	ContactDAO contactDao;
	
	//GET /user/{userId}/contacts
	@RequestMapping(path = "/user/{userId}/contacts", method = RequestMethod.GET)
	public List<Contact> getAllUserContacts(HttpServletRequest req, 
			HttpServletResponse res, @PathVariable int userId) {
		return contactDao.getAllUserContacts(userId);
	}
	
	//GET /user/{userId/contacts/{contactId}
	@RequestMapping(path = "/user/{userId}/contacts/{contactId}", method = RequestMethod.GET)
	public Contact getContactById(HttpServletRequest req, HttpServletResponse res, 
			@PathVariable int userId, @PathVariable int contactId) {
		return contactDao.getContactById(contactId);
	}
	
	//POST /user/{userId}/contacts
	
	@RequestMapping(path = "/user/{userId}/contacts", method = RequestMethod.POST)
	public Contact addContact(HttpServletRequest req, HttpServletResponse res,
			@PathVariable int userId, @RequestBody String contactJson) {
		return contactDao.addContact(userId, contactJson);
	}
	
	//PUT /user/{userId}/contacts/{contactId}
	@RequestMapping(path = "/user/{userId}/contacts/{contactId}", method = RequestMethod.PUT)
	public Contact updateContact(HttpServletRequest req, HttpServletResponse res,
			@PathVariable int userId, @PathVariable int contactId, @RequestBody String contactJson) {
		return contactDao.updateContact(userId, contactId, contactJson);
	}
	
	//DELETE /user/{userId}/contacts/{contactId}
	@RequestMapping(path = "/user/{userId}/contacts/{contactId}", method = RequestMethod.DELETE)
	public Boolean destroyContact(HttpServletRequest req, HttpServletResponse res, @PathVariable int userId,
			@PathVariable int contactId) {
		Boolean result = contactDao.destroyContact(userId, contactId);
		
		return result;
	}
}
