package hr.fer.zemris.opp.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Model for a single workplace of the kindergarden.
 * 
 * The workplace has rooms and a real adress.
 * 
 * @author domagoj
 *
 */

public class Workplace {

	/**
	 * Unique id of the workplace.
	 */
	private long id;
	
	/**
	 * Adress of the work place.
	 */
	private String adress;
	
	/**
	 * List of groups associated with the workplace.
	 */
	private List<Group> groups = new ArrayList<>();

	@Id @GeneratedValue
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@Column(length=200, nullable=false)
	public String getAdress() {
		return adress;
	}

	public void setAdress(String adress) {
		this.adress = adress;
	}

	@OneToMany(mappedBy="workplace", fetch=FetchType.LAZY, cascade=CascadeType.PERSIST, orphanRemoval=true)
	public List<Group> getGroups() {
		return groups;
	}

	public void setGroups(List<Group> groups) {
		this.groups = groups;
	}
	
	
}
