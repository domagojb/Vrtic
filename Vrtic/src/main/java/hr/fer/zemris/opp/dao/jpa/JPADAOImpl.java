package hr.fer.zemris.opp.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;

import hr.fer.zemris.opp.dao.DAO;
import hr.fer.zemris.opp.dao.DAOException;
import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.Workplace;
import hr.fer.zemris.opp.model.users.User;

/**
 * Implementation of the {@link DAO} interface.
 * 
 * @author domagoj
 *
 */
public class JPADAOImpl implements DAO {
	
	@Override
	public void insertUser(User user) throws DAOException {
		JPAEMProvider.getEntityManager().persist(user);
	}

	@Override
	public User getUser(String username, String passwordHash)
			throws DAOException {
		EntityManager em = JPAEMProvider.getEntityManager();
		User user = null;
		try {
			user = (User)em.createQuery("SELECT u FROM User u WHERE u.nick = :un AND u.passwordHash = :ph")
					.setParameter("un", username)
					.setParameter("ph", passwordHash)
					.getSingleResult();
		} catch(NoResultException e) {
			return null;
		}
		
		return user;
	}
	
	@Override
	public boolean userExists(String nick) throws DAOException {
		try {
			JPAEMProvider.getEntityManager().createQuery("SELECT u FROM User u WHERE u.nick = :un")
					.setParameter("un", nick)
					.getSingleResult();
		} catch(NoResultException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public List<User> getAllUsers() throws DAOException {
		EntityManager em = JPAEMProvider.getEntityManager();
		@SuppressWarnings("unchecked")
		List<User> users = (List<User>)em.createQuery("SELECT u FROM User u").getResultList();
		return users;
	}
	
	@Override
	public void removeUser(String nick) throws DAOException {
		EntityManager em = JPAEMProvider.getEntityManager();
		em.createQuery("DELETE FROM User u WHERE u.nick = :un").setParameter("un", nick).executeUpdate();
	}

	@Override
	public Child getChild(long id) throws DAOException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertChild(Child child) throws DAOException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Child> getChildrenInGroup(Group group) throws DAOException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Workplace getWorkplace(long id) throws DAOException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertWorplace(Workplace workplace) throws DAOException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Group> getGroupsInWorkplace(Workplace workplace)
			throws DAOException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> getUsersForGroup(Group group) throws DAOException {
		// TODO Auto-generated method stub
		return null;
	}
}