package hr.fer.zemris.opp.model;

import hr.fer.zemris.opp.model.users.User;

import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Represents a group (a room in a {@link Workplace}) with the list
 * of kids and their educators.
 * 
 * @author domagoj
 *
 */
@Entity
@Table(name="groups")
public class Group {

	/**
	 * Id of the group.
	 */
	private long id;
	
	/**
	 * The youngest a child can be to enter this group.
	 */
	private byte low;
	
	/**
	 * The oldest the child can be to enter this group.
	 */
	private byte high;
	
	/**
	 * The workplace this group is a part of.
	 */
	private Workplace workplace;
	
	/**
	 * Capacity of the group.
	 */
	private int capacity;
	
	/**
	 * List of children in this group.
	 */
	private List<Child> children = null;
	
	/**
	 * List of educators that work in the group.
	 */
	private List<User> educators;
	
	public Group() {
	}

	/**
	 * @return group id 
	 */
	@Id @GeneratedValue
	public long getId() {
		return id;
	}

	/**
	 * The id is auto generated so if you touch this you should know what you're doing.
	 * @param id the id to set 
	 */
	public void setId(long id) {
		this.id = id;
	}

	/**
	 * @return the youngest the child can be
	 */
	@Basic
	public byte getLow() {
		return low;
	}

	public void setLow(byte low) {
		this.low = low;
	}

	@Basic
	public byte getHigh() {
		return high;
	}

	public void setHigh(byte high) {
		this.high = high;
	}
	
	/**
	 * @return the capacity
	 */
	@Basic
	public int getCapacity() {
		return capacity;
	}

	/**
	 * @param capacity the capacity to set
	 */
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	@ManyToOne
	@JoinColumn(nullable=false)
	public Workplace getWorkplace() {
		return workplace;
	}

	public void setWorkplace(Workplace workplace) {
		this.workplace = workplace;
	}

	@OneToMany(mappedBy="group")
	public List<Child> getChildren() {
		return children;
	}

	public void setChildren(List<Child> children) {
		this.children = children;
	}

	@OneToMany(mappedBy="group")
	public List<User> getEducators() {
		return educators;
	}

	public void setEducators(List<User> educators) {
		this.educators = educators;
	}
	
	/**
	 * Returns the current number of children in the group.
	 * 
	 * @return number of children in the group
	 */
	public int count() {
		if (children == null) {
			return 0;
		}
		
		return children.size();
	}
	
	/**
	 * Tells if there is room in the group, i.e. the capacity hasn't been reached.
	 * 
	 * @return <code>true</code> if there is room for a child, else <code>false</code>
	 */
	public boolean hasRoom() {
		if (children == null) {
			return true;
		}
		
		if (children.size() == capacity) {
			return false;
		}
		
		return true;
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
		Group other = (Group) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
}
