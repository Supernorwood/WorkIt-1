package entities;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
public class Event {

	// FIELDS
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		private int id;
		
		private String title;
		
		@Column(name="event_date")
		private Date eventDate;
		
		private String description;
		
		@OneToOne(cascade=CascadeType.PERSIST)
		@JoinColumn(name = "address_id")
		private Address address;

		@JsonBackReference(value="userToEvent")
		@LazyCollection(LazyCollectionOption.FALSE)
		@ManyToOne(cascade = CascadeType.PERSIST)
		@JoinTable(name = "user_events", joinColumns=@JoinColumn(name = "event_id"), inverseJoinColumns=@JoinColumn(name = "user_id"))
		private User eventUser;
		
		//Gets and Sets
		public int getId() {
			return id;
		}

		public void setId(int id) {
			this.id = id;
		}

		public String getTitle() {
			return title;
		}

		public void setTitle(String title) {
			this.title = title;
		}

		public Date getEventDate() {
			return eventDate;
		}

		public void setEventDate(Date eventDate) {
			this.eventDate = eventDate;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}

		public Address getAddress() {
			return address;
		}

		public void setAddress(Address address) {
			this.address = address;
		}

		public User getEventUser() {
			return eventUser;
		}

		public void setEventUser(User eventUser) {
			this.eventUser = eventUser;
		}

		//To String

		@Override
		public String toString() {
			return "Event [id=" + id + ", title=" + title + "]";
		}

		

		
	
		
	
	
}
