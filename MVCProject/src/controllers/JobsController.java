package controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import data.JobsDAO;
import entities.Job;

@RestController
public class JobsController {
	
	@Autowired
	private JobsDAO jobsdao;
	
//  GET /user/{uid}/jobs
	@RequestMapping(path = "/user/{uid}/jobs", method = RequestMethod.GET)
	public List<Job> getAllJobs(
			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int uid
			){
		return jobsdao.getAllJobs(uid);
	}
	
//  GET /user/{uid}/jobs/{jid}
	@RequestMapping(path="/user/{uid}/jobs/{jid}", method = RequestMethod.GET)
	public Job getJobById(
			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int uid,
			@PathVariable int jid
			) {
		Job j = jobsdao.getJobById(uid, jid);
		
		if(j == null) {
			res.setStatus(404);
		}
		return j;
	}
	
//  POST /user/{uid}/jobs
	@RequestMapping(path="/user/{uid}/jobs", method=RequestMethod.POST)
	public Job addNewJob(
			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int uid, 
			@RequestBody String json) {
		
		Job job = jobsdao.addNewJob(uid, json);
		if(job == null) {
			res.setStatus(400);
		}
		return job;
	}
	
	
//  PUT /user/{uid}/todo/{tid}
	@RequestMapping(path="user/{uid}/jobs/{jid}", method=RequestMethod.PUT)
	public Job updateJob(

			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int uid, 
			@PathVariable int jid, 
			@RequestBody String json) {
		Job job = jobsdao.updateJob(uid, jid, json);
		if(job ==null) {
			res.setStatus(400);
		}
		return job;
	}
	
//  DELETE /user/{uid}/jobs/{jid}
	@RequestMapping(path="/user/{uid}/jobs/{jid}", method=RequestMethod.DELETE)
	public Boolean destroyJob(
			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int uid,
			@PathVariable int jid) {
		Boolean result = jobsdao.destroyJob(uid, jid);
		if(result == null) {
			res.setStatus(404);
		}
		return result;
	}
			

}
