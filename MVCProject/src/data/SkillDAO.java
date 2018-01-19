package data;

import java.util.List;

import entities.Skill;

public interface SkillDAO {

	public Boolean destroySkill(int uid, int sid);

	Boolean destroyJobSkill(int jid, int sid);
	
	public Skill addSkill(int uid, String json);
	
	public List<Skill> getAllSkills(int uid);
}
