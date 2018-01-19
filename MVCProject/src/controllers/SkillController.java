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

import data.SkillDAO;
import entities.Skill;

@RestController
public class SkillController {
	
	@Autowired
	private SkillDAO skillDAO;

	@RequestMapping(path="/user/{uid}/skill/{sid}", method=RequestMethod.DELETE)
	public Boolean destroySkill(@PathVariable int uid, @PathVariable int sid) {
		return skillDAO.destroySkill(uid, sid);
	}
	
	@RequestMapping(path="/user/{uid}/skill", method=RequestMethod.GET)
	public List<Skill> getAllSkills(
			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int uid
			){
		return skillDAO.getAllSkills(uid);
	}

			
	@RequestMapping(path = "/user/{uid}/skill", method=RequestMethod.POST)
	public Skill addNewSkill(
			HttpServletRequest req, 
			HttpServletResponse res, 
			@PathVariable int uid, 
			@RequestBody String json
			) {
		Skill skill = skillDAO.addSkill(uid, json);
		if (skill == null) {
			res.setStatus(400);
		}
		return skill;
	}
	
	
}
