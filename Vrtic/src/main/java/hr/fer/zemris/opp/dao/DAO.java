package hr.fer.zemris.opp.dao;

import java.util.List;

import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.Workplace;
import hr.fer.zemris.opp.model.users.User;

/**
 * The {@link DAO} interface creates an abstraction for easy database
 * communication. The interface defines methods that are essential
 * for the application's persistence work and allows the user (programmer)
 * to be rid of all direct database interaction.
 * 
 * @author domagoj
 *
 */
public interface DAO {

	/**
	 * Returns the {@link BlogUser} with the given <code>username</code>(or nick rather) and
	 * <code>passwordHash</code>. If there is no such user returns <code>null</code>.
	 * 
	 * @param username of the user to get
	 * @param passwordHash hashed password of the user to get
	 * @return {@link BlogUser} or <code>null</code> if that user doesn't exist
	 * @throws DAOException on error selecting user
	 */
	public User getUser(String username, String passwordHash) throws DAOException;
	
	/**
	 * Inserts a user into the database. Make sure to check if the user with given nickname
	 * already exists in the database before inserting.
	 * 
	 * @param user the {@link BlogUser} to insert
	 * @throws DAOException on error inserting into database
	 */
	public void insertUser(User user) throws DAOException;
	
	/**
	 * Get's all the users in the database. If there are no users returns 
	 * <code>null</code>.
	 * 
	 * @return all the users in the database, or <code>null</code> if there are none
	 * @throws DAOException
	 */
	public List<User> getAllUsers() throws DAOException;
	
	/**
	 * Checks if the user with the given nickname exists.
	 * 
	 * @param nick to check for
	 * @return <code>true</code> if a user exists, <code>false</code> else
	 * @throws DAOException on error looking up users
	 */
	public boolean userExists(String nick) throws DAOException;
	
	/**
	 * Removes the user with the given nick from the database.
	 * 
	 * @param nick of the user to delete 
	 * @throws DAOException on error removing
	 */
	public void removeUser(String nick) throws DAOException;
	
	public Child getChild(long id) throws DAOException;
	
	public void insertChild(Child child) throws DAOException;
	
	public List<Child> getChildrenInGroup(Group group) throws DAOException;
	
	public Workplace getWorkplace(long id) throws DAOException;
	
	public void insertWorplace(Workplace workplace) throws DAOException;
	
	public List<Group> getGroupsInWorkplace(Workplace workplace) throws DAOException;
	
	public List<User> getUsersForGroup(Group group) throws DAOException;
}