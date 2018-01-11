package data;

import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import entities.Job;

public interface JobsDAO {


	public List<Job> getAllJobs();
	public Job getJobById(int id);
	public Job addNewJob(String json);
	public Job updateJob(int id, String json);
	public Boolean destroyJob(int id);
}
