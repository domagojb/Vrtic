package hr.fer.zemris.opp.model.records;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * A simple flag that tells us if the sign ups are open or closed.
 * 
 * It's represented by a class so it can be saved in the database.
 * 
 * @author domagoj
 *
 */
@Entity
@Table(name="signuprecord")
public class SignUpRecord {

	/**
	 * Unique identifier.
	 */
	private long id;
	
	/**
	 * The flag, that if set to <code>true</code> means
	 * a sign up is open, else it's closed.
	 */
	private boolean signUpOpen = false;
	
	public SignUpRecord() {
	}
	
	/**
	 * @return the id
	 */
	@Id @GeneratedValue
	public long getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(long id) {
		this.id = id;
	}

	/**
	 * @return the signUpOpen
	 */
	@Basic
	public boolean isSignUpOpen() {
		return signUpOpen;
	}

	/**
	 * @param signUpOpen the signUpOpen to set
	 */
	public void setSignUpOpen(boolean signUpOpen) {
		this.signUpOpen = signUpOpen;
	}
}
