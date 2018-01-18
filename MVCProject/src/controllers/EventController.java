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

import data.EventDAO;
import entities.Event;

@RestController
public class EventController {
	
	@Autowired
	private EventDAO eventdao;

	@RequestMapping(path = "/user/{uid}/events", method = RequestMethod.GET)
	public List<Event> getAllEvents(
			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int uid
			){
		return eventdao.getAllEvents(uid);
	}
	
	@RequestMapping(path = "/user/{uid}/events/{eid}", method = RequestMethod.GET)
	public Event getEventById(
			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int uid,
			@PathVariable int eid
			) {
		Event e = eventdao.getEventById(uid, eid);
		if (e == null) {
			res.setStatus(404);
		}
		return e;
	}
	
	@RequestMapping(path = "/user/{uid}/events", method=RequestMethod.POST)
	public Event addNewEvent(
			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int uid, 
			@RequestBody String json
			) {
		Event event = eventdao.addNewEvent(uid, json);
		if (event == null) {
			res.setStatus(400);
		}
		return event;
	}
	
	@RequestMapping(path = "/user/{uid}/events/{eid}", method=RequestMethod.PUT)
	public Event updateEvent(
			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int uid, 
			@PathVariable int eid, 
			@RequestBody String json
			) {
		Event event = eventdao.updateEvent(uid, eid, json);
		if (event == null) {
			res.setStatus(400);
		}
		return event;
	}
	
	@RequestMapping(path="/user/{uid}/events/{eid}", method=RequestMethod.DELETE)
	public Boolean destroyEvent(
			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int uid,
			@PathVariable int eid
			) {
		Boolean result = eventdao.destroyEvent(uid, eid);
		if (result == null) {
			res.setStatus(404);
		}
		return result;
	}
	
}
