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
	
//  GET /user/{id}/jobs
	@RequestMapping(path = "/user/{id}/jobs", method = RequestMethod.GET)
	public List<Job> getAllJobs(
			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int id
			){
		return jobsdao.getAllJobs(id);
	}
	
//  GET /user/{uid}/jobs/{jid}
	@RequestMapping(path="/user/{uid}/jobs/{jid}", method = RequestMethod.GET)
	public Job getJobById(
			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int id
			) {
		Job j = jobsdao.getJobById(id);
		
		if(j == null) {
			res.setStatus(404);
		}
		return j;
	}
	
//  POST /user/{uid}/jobs
	@RequestMapping(path="/user/{uid}/jobs", method=RequestMethod.PUT)
	public Job addNewJob(
			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int uid, 
			@RequestBody String json) {
		
		Job job = jobsdao.addNewJob()
	}

}
