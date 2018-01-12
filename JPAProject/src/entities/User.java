package entities;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class User {

	  //FIELDS
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
	  
	  @ManyToOne
	  @JoinColumn(name="address_id")
	  private Address address;
	  
	  @Column(name = "created_date")
	  private Date createdDate;
	  
	  private Boolean active;
	  
	  @Column(name = "permission_level")
	  private int permissionLevelId;

	  
	  
	  
	//GETS AND SETS  
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

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

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

	
	//TOSTRING
	@Override
	public String toString() {
		return "User [id=" + id + ", email=" + email + ", password=" + password + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", address=" + address + ", createdDate=" + createdDate + ", active="
				+ active + ", permissionLevelId=" + permissionLevelId + ", getId()=" + getId() + ", getEmail()="
				+ getEmail() + ", getPassword()=" + getPassword() + ", getFirstName()=" + getFirstName()
				+ ", getLastName()=" + getLastName() + ", getAddress()=" + getAddress() + ", getCreatedDate()="
				+ getCreatedDate() + ", getActive()=" + getActive() + ", getPermissionLevelId()="
				+ getPermissionLevelId() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}
	  
	
	
	  
	    
}
