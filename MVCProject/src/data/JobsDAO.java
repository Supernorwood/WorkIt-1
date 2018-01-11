package data;

import java.util.List;

import entities.Job;

public interface JobsDAO {


	public List<Job> getAllJobs(int uid);
	public Job getJobById(int uid, int jid);
	public Job addNewJob(int uid, String json);
	public Job updateJob(int uid, int jid, String json);
	public Boolean destroyJob(int uid, int jid);
}
