package data;

public interface SkillDAO {

	public Boolean destroySkill(int uid, int sid);

	Boolean destroyJobSkill(int jid, int sid);
	
}
