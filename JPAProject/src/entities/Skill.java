package entities;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name = "skills")
public class Skill {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	private String skill;

	@JsonBackReference(value="userToSkill")
	@LazyCollection(LazyCollectionOption.FALSE)
	@ManyToOne(cascade = CascadeType.PERSIST)
	@JoinTable(name = "user_skills", joinColumns=@JoinColumn(name = "skill_id"), inverseJoinColumns=@JoinColumn(name = "user_id"))
	private User skillUser;
	
	@JsonBackReference(value="jobToSkill")
	@ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	@LazyCollection(LazyCollectionOption.FALSE)
	@JoinTable(name = "job_skills", joinColumns=@JoinColumn(name = "job_id"), inverseJoinColumns=@JoinColumn(name = "skill_id"))
	private Job skillJob;

	public int getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSkill() {
		return skill;
	}

	public void setSkill(String skill) {
		this.skill = skill;
	}

	public Job getSkillJob() {
		return skillJob;
	}

	public void setSkillJob(Job skillJob) {
		this.skillJob = skillJob;
	}

	public User getSkillUser() {
		return skillUser;
	}

	public void setSkillUser(User skillUser) {
		this.skillUser = skillUser;
	}

	@Override
	public String toString() {
		return "Skill [id=" + id + ", skill=" + skill + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Skill other = (Skill) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
}
