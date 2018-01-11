package data;

import java.util.List;

import entities.Job;

public interface JobsDAO {

	public List<Job> getAllJobs();
	
	public Job getJobById(int id);
	
	
	
}
