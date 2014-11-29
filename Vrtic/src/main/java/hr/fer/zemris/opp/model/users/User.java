package hr.fer.zemris.opp.model.users;

import java.util.List;

import hr.fer.zemris.opp.model.Group;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

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