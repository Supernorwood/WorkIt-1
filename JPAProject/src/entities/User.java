package entities;

import java.sql.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class User {

	// FIELDS
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String email;

	@Column(name = "pwd")
	private String password;

	@Column(name = "first_name")
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

//	@ManyToOne
//	@JoinColumn(name = "address_id")
//	private Address address;

	@Column(name = "created_date")
	private Date createdDate;

	private Boolean active;

	@Column(name = "permission_level")
	private int permissionLevelId;
	
	@JsonManagedReference(value="userToSkill")
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "skillUser", cascade = CascadeType.PERSIST)
	private List<Skill> userSkills;

	@JsonManagedReference(value="userToJob")
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "user", cascade = CascadeType.PERSIST)
	List<Job> jobs;

	// GETS AND SETS
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

//	public Address getAddress() {
//		return address;
//	}
//
//	public void setAddress(Address address) {
//		this.address = address;
//	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public int getPermissionLevelId() {
		return permissionLevelId;
	}

	public void setPermissionLevelId(int permissionLevelId) {
		this.permissionLevelId = permissionLevelId;
	}

	public List<Job> getJobs() {
		return jobs;
	}

	public void setJobs(List<Job> jobs) {
		this.jobs = jobs;
	}

	public List<Skill> getUserSkills() {
		return this.userSkills;
	}

	public void setUserSkills(List<Skill> userSkills) {
		this.userSkills = userSkills;
	}

	// TOSTRING
	@Override
	public String toString() {
		return "User [id=" + id + ", email=" + email + ", password=" + password + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", createdDate=" + createdDate + ", active="
				+ active + ", permissionLevelId=" + permissionLevelId + ", getId()=" + getId() + ", getEmail()="
				+ getEmail() + ", getPassword()=" + getPassword() + ", getFirstName()=" + getFirstName()
				+ ", getLastName()=" + getLastName() + ", getCreatedDate()="
				+ getCreatedDate() + ", getActive()=" + getActive() + ", getPermissionLevelId()="
				+ getPermissionLevelId() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}

}
