package hr.fer.zemris.opp.dao;

import java.util.List;

import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.Parent;
import hr.fer.zemris.opp.model.Workplace;
import hr.fer.zemris.opp.model.records.ChildRecord;
import hr.fer.zemris.opp.model.records.EducatorActivity;
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
	 * Returns the {@link User} with the given <code>username</code>(or nick rather) and
	 * <code>passwordHash</code>. If there is no such user returns <code>null</code>.
	 * 
	 * @param username of the user to get
	 * @param passwordHash hashed password of the user to get
	 * @return {@link User} or <code>null</code> if that user doesn't exist
	 * @throws DAOException on error selecting user
	 */
	public User getUser(String username, String passwordHash) throws DAOException;
	
	/**
	 * Returns the {@link User} with given <code>id</code>.
	 * 
	 * @param id of the user to fetch
	 * @return User with given id or <code>null</code> if he doesn't exist
	 * @throws DAOException on error selecting user
	 */
	public User getUser(long id) throws DAOException;
	
	/**
	 * Inserts a user into the database. Make sure to check if the user with given nickname
	 * already exists in the database before inserting.
	 * 
	 * @param user the {@link User} to insert
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
	
	/**
	 * Retrieves the {@link Child} with the given <code>id</code> 
	 * from the database.
	 * 
	 * @param id of the child to fetch
	 * @return {@link Child} or <code>null</code> if it doesn't exist
	 * @throws DAOException on error fetching child
	 */
	public Child getChild(long id) throws DAOException;
	
	/**
	 * Removes the child with given <code>id</code> from the
	 * database.
	 * 
	 * @param id of the child to remove
	 * @throws DAOException on error removing child
	 */
	public void removeChild(long id) throws DAOException;
	
	/**
	 * Persists given child into database.
	 * 
	 * @param child to persist
	 * @throws DAOException on error persisting
	 */
	public void insertChild(Child child) throws DAOException;
	
	public List<Child> getChildrenInGroup(Group group) throws DAOException;
	
	/**
	 * Returns a list of children in the group with the given <code>id</code>.
	 * 
	 * If there are no children returns <code>null</code>.
	 * 
	 * @param id the id of the group from which to get the list of children
	 * @return {@link List} of children or <code>null</code> if there are none
	 * @throws DAOException on error retrieving children
	 */
	public List<Child> getChildrenInGroup(long id) throws DAOException;
	
	/**
	 * Inserts the given parent into the database.
	 * 
	 * @param parent to persist
	 * @throws DAOException on error persisting
	 */
	public void insertParent(Parent parent) throws DAOException;
	
	/**
	 * Returns the parent with the given <code>id</code> or <code>null</code> if there is
	 * no such parent.
	 * 
	 * @param id of the parent to fetch
	 * @return {@link Parent} or <code>null</code>
	 * @throws DAOException on error fetching parent
	 */
	public Parent getParent(long id) throws DAOException;
	
	/**
	 * Returns all the parents in the database or <code>null</code> if
	 * there are no parents.
	 * 
	 * @return List of all the parents in the database or <code>null</code> if there are none
	 * @throws DAOException on error retrieving errors
	 */
	public List<Parent> getAllParents() throws DAOException;
	
	/**
	 * Returns {@link Workplace} with given <code>id</code>.
	 * 
	 * @param id of the workplace to fetch
	 * @return {@link Workplace} with given id, or <code>null</code> if it doesn't exist
	 * @throws DAOException on error retrieving {@link Workplace}
	 */
	public Workplace getWorkplace(long id) throws DAOException;
	
	/**
	 * Returns a list of all workspaces.
	 * 
	 * @return a list of all workspaces
	 * @throws DAOException on error retrieving list
	 */
	public List<Workplace> getAllWorkplaces() throws DAOException;
	
	/**
	 * Inserts a new {@link Workplace} into the database.
	 * 
	 * @param workplace to insert
	 * @throws DAOException on error inserting
	 */
	public void insertWorplace(Workplace workplace) throws DAOException;
	
	/**
	 * Returns all the groups in the database or <code>null</code> if there are no
	 * groups.
	 * 
	 * @return List of all groups or <code>null</code> if there are no groups
	 * @throws DAOException on error retrieving groups
	 */
	public List<Group> getAllGroups() throws DAOException;
	
	/**
	 * Returns the {@link Group} with given <code>id</code> or <code>null</code>
	 * if there is no such group.
	 * 
	 * @param id of group to fetch
	 * @return {@link Group} with given id or <code>null</code> if there is none
	 * @throws DAOException on error retrieving group
	 */
	public Group getGroup(long id) throws DAOException;
	
	public List<Group> getGroupsInWorkplace(Workplace workplace) throws DAOException;
	
	public List<User> getUsersForGroup(Group group) throws DAOException;

	/**
	 * Insert group into database.
	 * 
	 * @param g group to insert
	 */
	public void insertGroup(Group g);
	
	/**
	 * Inserts record into database.
	 * 
	 * @param r record to insert
	 */
	public void insertRecord(ChildRecord r);
	
	/**
	 * Inserts the given {@link EducatorActivity} into the database.
	 * 
	 * @param ea the activity to insert
	 */
	public void insertEducatorActivity(EducatorActivity ea);
}