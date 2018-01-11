package data;

import java.util.List;

import entities.Job;

public interface JobsDAO {

	public List<Job> index(int uid);
	public Job show(int uid, int jid);
	public Job create(int uid, String jobJson);
	public Job update(int uid, int jid, String jobJson);
	public Boolean destroy(int uid, int jid);
	
	
	
}
