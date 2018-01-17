package entities;

import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Address {
	
	
	  //FIELDS
	  @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private int id;
	
	  	private String street;
	  	private String street2;
	  	private String city;
	  	private String state;
	  	private String zip;
	  	private String country;
	  	
	  	@JsonIgnore
	    @OneToMany(mappedBy="address")
	    private Set <User> user;

		@JsonIgnore
	    @OneToMany(mappedBy="address")
	    private Set <Job> job;
	  	
	  	
	  	
	  	//GETS AND SETS
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getStreet() {
			return street;
		}
		public void setStreet(String street) {
			this.street = street;
		}
		public String getStreet2() {
			return street2;
		}
		public void setStreet2(String street2) {
			this.street2 = street2;
		}
		public String getCity() {
			return city;
		}
		public void setCity(String city) {
			this.city = city;
		}
		public String getState() {
			return state;
		}
		public void setState(String state) {
			this.state = state;
		}
		public String getZip() {
			return zip;
		}
		public void setZip(String zip) {
			this.zip = zip;
		}
		public String getCountry() {
			return country;
		}
		public void setCountry(String country) {
			this.country = country;
		}
		
		
		public Set<User> getUser() {
			return user;
		}
		public void setUser(Set<User> user) {
			this.user = user;
		}
		
		
		public Set<Job> getJob() {
			return job;
		}
		public void setJob(Set<Job> job) {
			this.job = job;
		}
		
		
		//TOSTRING
		@Override
		public String toString() {
			return "Address [id=" + id + ", street=" + street + ", street2=" + street2 + ", city=" + city + ", state="
					+ state + ", zip=" + zip + ", country=" + country + "]";
		}
		
		}
	  	

