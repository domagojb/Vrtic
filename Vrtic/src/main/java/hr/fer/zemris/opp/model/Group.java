package hr.fer.zemris.opp.model;

import hr.fer.zemris.opp.model.users.User;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Represents a group (a room in a {@link Workplace})
 * of kids and their educators.
 * 
 * @author domagoj
 *
 */

public class Group {

	private long id;
	
	private byte low;
	
	private byte high;
	
	private Workplace workplace;
	
	private List<Child> children;
	
	private List<User> educators;
	
}
