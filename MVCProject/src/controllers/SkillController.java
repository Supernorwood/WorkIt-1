package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import data.SkillDAO;

@RestController
public class SkillController {
	
	@Autowired
	private SkillDAO skillDAO;
	

	@RequestMapping(path="/user/{uid}/skill/{sid}", method=RequestMethod.DELETE)
	public Boolean destroySkill(@PathVariable int uid, @PathVariable int sid) {
		return skillDAO.destroySkill(uid, sid);
	}
	
	@RequestMapping(path="/user/{userId}/jobs/{jobId}/skill/{sid}", method=RequestMethod.DELETE)
	public Boolean destroyJobSkill(@PathVariable int uid, @PathVariable int jid, @PathVariable int sid) {
		return skillDAO.destroyJobSkill(uid, jid, sid);
	}
	
}
