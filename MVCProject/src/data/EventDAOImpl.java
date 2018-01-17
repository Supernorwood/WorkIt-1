package data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;

import entities.Event;
import entities.User;

@Transactional
@Repository
public class EventDAOImpl implements EventDAO{

	@PersistenceContext
	private EntityManager em;
	
	@Override
	public List<Event> getAllEvents(int uid) {
		String query = "SELECT e from Event e WHERE e.eventUser.id = :uid";
		List<Event> events = em.createQuery(query, Event.class)
				.setParameter("uid", uid)
				.getResultList();
		return events;
	}

	@Override
	public Event getEventById(int uid, int eid) {
		Event event = em.find(Event.class, eid);
		if(event == null || event.getEventUser().getId() !=uid) {
			return null;
		}
		return event;
	}

	@Override
	public Event addNewEvent(int uid, String json) {
		ObjectMapper mapper = new ObjectMapper();
		Event newEvent = null;
		try {
			newEvent = mapper.readValue(json, Event.class);
			User u = em.find(User.class, uid);
			newEvent.setEventUser(u);
			em.persist(newEvent);
			em.flush();
			return newEvent;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Event updateEvent(int uid, int eid, String json) {
		ObjectMapper mapper = new ObjectMapper();
		Event managedEvent = em.find(Event.class, eid);
		Event upEvent = null;
		try {
			upEvent = mapper.readValue(json, Event.class);
			User u = em.find(User.class, uid);
			managedEvent.setTitle(upEvent.getTitle());
			managedEvent.setEventDate(upEvent.getEventDate());
			managedEvent.setDescription(upEvent.getDescription());
			managedEvent.setAddress(upEvent.getAddress());
			return managedEvent;			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Boolean destroyEvent(int uid, int eid) {
		String queryJoin = "DELETE FROM user_events WHERE event_id = :eid";
		em.createNativeQuery(queryJoin).setParameter("eid", eid).executeUpdate();
		String query = "DELETE FROM Event WHERE id = :eid";
		em.createQuery(query).setParameter("eid", eid).executeUpdate();
		return !em.contains(em.find(Event.class, eid));
	}

}
