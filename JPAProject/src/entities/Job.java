package entities;

import java.sql.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class Job {

	// FIELDS
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@JsonBackReference(value="userToJob")
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	private Boolean active;

	private String company;

	private String title;

	private String link;

	@OneToOne(cascade=CascadeType.PERSIST)
	@JoinColumn(name = "address_id")
	private Address address;

	private double salary;

	@Column(name = "closing_date")
	private Date closingDate;

	@Column(name = "created_date")
	private Date createdDate;

	@Column(name = "last_update")
	private Date lastUpdate;
	
	@JsonManagedReference(value="jobToSkill")
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "skillJob", cascade = CascadeType.PERSIST)
	private List<Skill> jobSkills;
	
	// GETS AND SETS
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public double getSalary() {
		return salary;
	}

	public void setSalary(double salary) {
		this.salary = salary;
	}

	public Date getClosingDate() {
		return closingDate;
	}

	public void setClosingDate(Date closingDate) {
		this.closingDate = closingDate;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(Date lastUpdate) {
		this.lastUpdate = lastUpdate;
	}
	
	public List<Skill> getJobSkills() {
		return jobSkills;
	}

	public void setJobSkills(List<Skill> jobSkills) {
		this.jobSkills = jobSkills;
	}

	@Override
	public String toString() {
		return "Job [id=" + id + ", user=" + user + ", active=" + active + ", company=" + company + ", title=" + title
				+ ", link=" + link + ", address=" + address + ", salary=" + salary + ", closingDate=" + closingDate
				+ ", createdDate=" + createdDate + ", lastUpdate=" + lastUpdate + "]";
	}

}
