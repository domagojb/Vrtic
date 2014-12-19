package hr.fer.zemris.opp.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;

import hr.fer.zemris.opp.dao.DAO;
import hr.fer.zemris.opp.dao.DAOException;
import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.Parent;
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
	public User getUser(long id) throws DAOException {
		EntityManager em = JPAEMProvider.getEntityManager();
		User user = null;
		try {
			user = (User)em.createQuery("SELECT u FROM User u WHERE u.id = :ui")
					.setParameter("ui", id)
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
		JPAEMProvider.getEntityManager().persist(child);
	}

	@Override
	public List<Child> getChildrenInGroup(Group group) throws DAOException {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public void insertParent(Parent parent) throws DAOException {
		JPAEMProvider.getEntityManager().persist(parent);
	}
	
	@Override
	public Parent getParent(long id) throws DAOException {
		EntityManager em = JPAEMProvider.getEntityManager();
		Parent p = null;
		try {
			p = (Parent)em.createQuery("SELECT p FROM Parent p WHERE p.id = :pi")
					.setParameter("pi", id)
					.getSingleResult();
		} catch(NoResultException e) {
			return null;
		}
		
		return p;
	}
	
	@Override
	public List<Parent> getAllParents() throws DAOException {
		EntityManager em = JPAEMProvider.getEntityManager();
		@SuppressWarnings("unchecked")
		List<Parent> parents = (List<Parent>)em.createQuery("SELECT p FROM Parent p").getResultList();
		return parents;
	}

	@Override
	public Workplace getWorkplace(long id) throws DAOException {
		EntityManager em = JPAEMProvider.getEntityManager();
		Workplace w = null;
		try {
			w = (Workplace)em.createQuery("SELECT w FROM Workplace w WHERE w.id = :ui")
					.setParameter("ui", id)
					.getSingleResult();
		} catch(NoResultException e) {
			return null;
		}
		
		return w;
	}
	
	@Override
	public List<Workplace> getAllWorkplaces() throws DAOException {
		EntityManager em = JPAEMProvider.getEntityManager();
		@SuppressWarnings("unchecked")
		List<Workplace> workplaces = (List<Workplace>)em.createQuery("SELECT w FROM Workplace w").getResultList();
		return workplaces;
	}

	@Override
	public void insertWorplace(Workplace workplace) throws DAOException {
		JPAEMProvider.getEntityManager().persist(workplace);
	}
	
	@Override
	public List<Group> getAllGroups() throws DAOException {
		EntityManager em = JPAEMProvider.getEntityManager();
		@SuppressWarnings("unchecked")
		List<Group> groups = (List<Group>)em.createQuery("SELECT g FROM Group g").getResultList();
		return groups;
	}
	
	@Override
	public Group getGroup(long id) throws DAOException {
		EntityManager em = JPAEMProvider.getEntityManager();
		Group g = null;
		try {
			g = (Group)em.createQuery("SELECT g FROM Group g WHERE g.id = :gi")
					.setParameter("gi", id)
					.getSingleResult();
		} catch(NoResultException e) {
			return null;
		}
		
		return g;
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
	
	@Override
	public void insertGroup(Group g) {
		JPAEMProvider.getEntityManager().persist(g);
	}
}