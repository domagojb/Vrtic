package hr.fer.zemris.opp.model.users;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.records.ChildRecord;
import hr.fer.zemris.opp.model.records.EducatorActivity;
import hr.fer.zemris.opp.servlets.forms.EnterEducatorActivityForm;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.servlet.http.HttpServletRequest;

/**
 * Defines a user of the web application that can login into the
 * system and do adequate functions. The user has a unique id
 * and nick. First and last name show the users identity. The password
 * is hashed for security reasons.
 * 
 * The user has three types: Administrator, Educator and Accountant.
 * 
 * The types are defined by strings as follows: "adm", "edu" and "acc".
 * The type of each user is saved internally and can be retrieved from
 * {@link #getType()}.
 * 
 * @author Domagoj Boros
 *
 */
@Entity
@Table(name="users")
public class User {

	// id, firstName, lastName, nick, email and passwordHash.
	
	/**
	 * Users id.
	 */
	private Long id;
	
	/**
	 * Users first name.
	 */
	private String firstName;
	
	/**
	 * Users last name.
	 */
	private String lastName;
	
	/**
	 * Users nickname.
	 */
	private String nick;
	
	/**
	 * Users password encrypted in hash.
	 */
	private String passwordHash;
	
	/**
	 * User type.
	 */
	private String type;
	
	/**
	 * Possible user types.
	 */
	private final String[] types = new String[] { "adm", "edu", "acc" };
	
	/**
	 * The group that this user works in.
	 */
	private Group group = null;
	
	/**
	 * Activity list of the user. Used by educators and admins.
	 */
	private List<EducatorActivity> activityLog;
	
	public User() {
	}
	
	/**
	 * @return the id
	 */
	@Id @GeneratedValue
	public Long getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * @return the firstName
	 */
	@Column(length=40, nullable=false)
	public String getFirstName() {
		return firstName;
	}

	/**
	 * @param firstName the firstName to set
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	/**
	 * @return the lastName
	 */
	@Column(length=40, nullable=false)
	public String getLastName() {
		return lastName;
	}

	/**
	 * @param lastName the lastName to set
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	/**
	 * @return the nick
	 */
	@Column(length=40, nullable=false, unique=true)
	public String getNick() {
		return nick;
	}

	/**
	 * @param nick the nick to set
	 */
	public void setNick(String nick) {
		this.nick = nick;
	}

	/**
	 * @return the passwordHash
	 */
	@Column(length=40, nullable=false)
	public String getPasswordHash() {
		return passwordHash;
	}

	/**
	 * @param passwordHash the passwordHash to set
	 */
	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}
	
	/**
	 * @return the user type
	 */
	@Column(length=3, nullable=false)
	public String getType() {
		return type;
	}
	
	@ManyToOne
	public Group getGroup() {
		return group;
	}
	
	/**
	 * Set the working group of this user.
	 * 
	 * If set too null, that means the user is not working
	 * in a group.
	 * 
	 * @param group
	 */
	public void setGroup(Group group) {
		this.group = group;
	}
	
	/**
	 * @return the activityLog
	 */
	@OneToMany(mappedBy="educator")
	public List<EducatorActivity> getActivityLog() {
		return activityLog;
	}

	/**
	 * @param activityLog the activityLog to set
	 */
	public void setActivityLog(List<EducatorActivity> activityLog) {
		this.activityLog = activityLog;
	}

	/**
	 * Fills the attendance {@link ChildRecord} for his group.
	 * 
	 * @param req inherited from the servlet the request was gotten from
	 * @throws FormException when there is an error in the form, error message contains error code
	 */
	public void FillAttendanceRecord(HttpServletRequest req) throws FormException {
		String sGID = req.getParameter("gid");
		String[] sCIDs = req.getParameterValues("children");
		String sDate = req.getParameter("date");
		Date date = null;
		try {
			date = new SimpleDateFormat("yyyy-MM-dd").parse(sDate);
		} catch (ParseException e1) {
			throw new FormException("Interna pogreska -557");
		}
		
		List<Child> children = new ArrayList<Child>();
		
		if (sCIDs != null) {
			for (String sCID : sCIDs) {
				
				long cid;
				try {
					cid = Long.valueOf(sCID);
					System.out.println("CID: " + cid);
				} catch (NumberFormatException e) {
					throw new FormException("Interna pogreska -558");
				}
				
				Child c = DAOProvider.getDAO().getChild(cid);
				children.add(c);

			}
		} 
		
		Long gid = null;
		try {
			gid = Long.valueOf(sGID);
		} catch (NumberFormatException e) {
			throw new FormException("Interna pogreska -559");
		}
		
		Group g = DAOProvider.getDAO().getGroup(gid);
		
		ChildRecord record = new ChildRecord();
		record.setGroup(g);
		record.setPresentChildren(children);
		record.setDate(date);
		
		for(Child c : children) {
			c.addRecord(record);
		}
		
		DAOProvider.getDAO().insertRecord(record);
	}
	
	/**
	 * Fills an {@link EducatorActivity} from the form in the {@link HttpServletRequest}.
	 * The user the form is filled for written in the form. This user only extracts and saves
	 * the log.
	 * 
	 * The form is validated by this method. 
	 * 
	 * The returned form may contain errors. If it contains validation errors 
	 * the form will be returned with the errors map set. If there are internal
	 * errors {@link FormException} will be thrown.
	 * 
	 * If the form is correct the log will be saved.
	 * 
	 * @param req inherited from the request that the form came from
	 * @return the filled form, with it's errors
	 * @throws FormException on internal errors in the form
	 */
	public EnterEducatorActivityForm FillActivityLog(HttpServletRequest req) throws FormException {
		EnterEducatorActivityForm form = new EnterEducatorActivityForm();
		form.fillFromHttpRequest(req);
		form.validate();
		
		if (form.hasErrors() == false) {
			EducatorActivity ea = form.getActivityFromForm();
			DAOProvider.getDAO().insertEducatorActivity(ea);
		}
		
		return form;
	}

	
	/**
	 * Set the user type.
	 * 
	 * Allowed values are:
	 * <ol>
	 *   <li>"adm" for the admin account</li>
	 *   <li>"acc" for the accountant account</li>
	 *   <li>"edu" for the educator account</li>
	 * </ol>
	 * 
	 * Throws  {@link InvalidUserTypeException} on type not being one of the
	 * allowed values.
	 * 
	 * @param type of the user
	 * @throws InvalidUserTypeException on invalid type
	 */
	public void setType(String type) throws InvalidUserTypeException {
		boolean goodType = false;
		for (String t : this.types) {
			if (t.equals(type)) {
				goodType = true;
				break;
			}
		}
		
		if (!goodType) {
			throw new InvalidUserTypeException("User type '"+ type + "' does not exist.");
		}
		this.type = type;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	/**
	 * Two users are equal of their ID's are equal.
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (!(obj instanceof User)) {
			return false;
		}
		User other = (User) obj;
		if (id == null) {
			if (other.id != null) {
				return false;
			}
		} else if (!id.equals(other.id)) {
			return false;
		}
		return true;
	}
	
}
