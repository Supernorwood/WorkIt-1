package data;

import java.util.List;

import entities.Event;

public interface EventDAO {
	
	public List<Event> getAllEvents(int uid);
	public Event getEventById(int uid, int eid);
	public Event addNewEvent(int uid, String json);
	public Event updateEvent(int uid, int eid, String json);
	public Boolean destroyEvent(int uid, int eid);
	
}
