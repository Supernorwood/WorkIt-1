package data;

import javax.persistence.NoResultException;

import entities.Skill;
import entities.User;

public interface AuthDAO {
	public User register(User u);

	public User login(User u);
	
	public User getUserById(int userId);
	
	public User authenticateUser(User user) throws NoResultException;
	
	public User updateUser(int userId, String userJson);
	
	public Skill addUserSkill(int userId, String skillJson);
	
	public Boolean destroyUser(int userId);

	public Boolean destroySkill(int skillId);
}