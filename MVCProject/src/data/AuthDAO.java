package data;

import javax.persistence.NoResultException;

import entities.User;

public interface AuthDAO {
	public User register(User u);

	public User login(User u);
	
	public User authenticateUser(User user) throws NoResultException;
}