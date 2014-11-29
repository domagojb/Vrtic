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
@Entity
@Table(name="workplaces")
public class Workplace {

	/**
	 * Unique id of the workplace.
	 */
	private long id;
	
	/**
	 * Adsress of the work place.
	 */
	private String address;
	
	/**
	 * Town of the workplace.
	 */
	private String town;
	
	/**
	 * List of groups associated with the workplace.
	 */
	private List<Group> groups = new ArrayList<>();
	
	public Workplace() {
	}

	@Id @GeneratedValue
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@Column(length=200, nullable=false)
	public String getAddress() {
		return address;
	}

	public void setAddress(String adress) {
		this.address = adress;
	}
	
	@Column(length=50, nullable=false)
	public String getTown() {
		return town;
	}

	public void setTown(String town) {
		this.town = town;
	}

	@OneToMany(mappedBy="workplace", fetch=FetchType.LAZY, cascade=CascadeType.PERSIST, orphanRemoval=true)
	public List<Group> getGroups() {
		return groups;
	}

	public void setGroups(List<Group> groups) {
		this.groups = groups;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (id ^ (id >>> 32));
		return result;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Workplace other = (Workplace) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
}
