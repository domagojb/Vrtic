package hr.fer.zemris.opp.servlets.forms;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.users.User;
import hr.fer.zemris.opp.password.PasswordHasher;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.management.BadAttributeValueExpException;
import javax.management.InvalidAttributeValueException;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.type.descriptor.sql.NVarcharTypeDescriptor;

/**
 * Form used for editing user info.
 * 
 * @author domagoj
 *
 */
public class EditUserForm {

	/**
	 * The user information that has to be given in the form.
	 * Default set to empty so you get an empty form when creating a new one.
	 */
	private Long id;
	private String firstName = "";
	private String lastName = "";
	private String nick = "";
	private String password = "";
	private String type = "";
	
	/**
	 * Options that tell whether the information or the password are attempted to
	 * be changed.
	 */
	public enum Option {
		INFO,
		PASSWORD
	}
	
	private Option option = Option.INFO;
	
	// Mapa<property, error message>
	/**
	 * Map of potential errors.
	 */
	Map<String, String> errors = new HashMap<>();
	
	/**
	 * Returns the error mesage mapped to <code>name</code>, or
	 * <code>null</code> if there is no error.
	 * 
	 * @param name name of the error
	 * @return the error mesage mapped to <code>name</code>, or <code>null</code> if there is no error.
	 */
	public String getError(String name) {
		return errors.get(name);
	}
	
	/**
	 * @return <code>true</code> if the form has errors, else <code>false</code>
	 */
	public boolean hasErrors() {
		return !errors.isEmpty();
	}
	
	/**
	 * Checks if error with given name exists.
	 * 
	 * @param name of the error to check
	 * @return <code>true</code> if an error exists, <code>false</code> else.
	 */
	public boolean hasError(String name) {
		return errors.containsKey(name);
	}
	
	/**
	 * Fills up the form from the request for the given {@link Option}.
	 * 
	 */
	public void fillFromHttpRequest(HttpServletRequest req, Option o) {
		this.option = o;
		
		if (option == Option.INFO) {
			this.id = Long.valueOf(req.getParameter("id"));
			this.firstName = req.getParameter("firstname");
			this.lastName = req.getParameter("lastname");
			this.nick = req.getParameter("nick");
			this.type = req.getParameter("userType");
			return;
		} 
		
		this.password = req.getParameter("password");
	}
	
	/**
	 * Fills the form from the data given by {@link User} u.
	 * 
	 * @param u user to fill form from
	 */
	public void fillFormFromUser(User u) {
		this.firstName = u.getFirstName();
		this.lastName = u.getLastName();
		this.nick = u.getNick();
		this.password = "";
		this.type = u.getType();
	}
	
	/**
	 * Make sure to call {@link #validate()} before to check for errors.
	 * The method will calculate the password hash for the given password.
	 * 
	 * @return a {@link BlogUser} filled with information from this form.
	 *  
	 */
	public User getUserFromForm() {
		User user = new User();
		
		user.setFirstName(firstName);
		user.setLastName(lastName);
		user.setType(type);
		user.setNick(nick);
		user.setPasswordHash(PasswordHasher.getHexHash(password));
		
		return user;
	}
	
	/**
	 * Checks the form. If there are any error it will map them.
	 * Check {@link #hasErrors()} and {@link #hasError(String)} for
	 * errors after calling this method.
	 */
	public void validate() {
		errors.clear();
		
		if (option == Option.INFO) {
			validateInfo();
		} else {
			validatePassword();
		}
		
	}

	/**
	 * Validates the given information.
	 */
	private void validateInfo() {
		if(nick.isEmpty()) {
			errors.put("nick", "Koriscnicko ime je obavezno");
		} else {
			List<User> users = DAOProvider.getDAO().getAllUsers();
			for (User u : users) {
				if (u.getNick().equals(nick) && u.getId() != id) {
					errors.put("nick", "Korisnicko ime vec postoji");
				}
			}
		}
		
		if(firstName.isEmpty()) {
			errors.put("firstname", "Ime je obavezno");
		}
		
		if(lastName.isEmpty()) {
			errors.put("lastname", "Prezime je obavezno");
		}
	}

	/**
	 * Validates the given password.
	 */
	private void validatePassword() {
		if(password.isEmpty()) {
			errors.put("password", "Lozinka ne može biti prazna");
		}
	}

	/**
	 * @return the firstName
	 */
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
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * 
	 * @return the user type
	 */
	public String getType() {
		return type;
	}
	
	/**
	 * 
	 * @param type user type to set
	 */
	public void setType(String type) {
		this.type = type;
	}
}
