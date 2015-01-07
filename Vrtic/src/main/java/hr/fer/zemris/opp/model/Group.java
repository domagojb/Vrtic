package hr.fer.zemris.opp.model;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.dao.jpa.JPAEMProvider;
import hr.fer.zemris.opp.model.records.ChildRecord;
import hr.fer.zemris.opp.model.users.User;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.mysql.fabric.xmlrpc.base.Array;

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
	 * List of children that want to join this group.
	 */
	private List<Child> signUpList;
	
	/**
	 * List of educators that work in the group.
	 */
	private List<User> educators;
	
	/**
	 * All of the attendance records for this group.
	 */
	private List<ChildRecord> records;
	
	/**
	 * List used by the sign up algorithm. 
	 * This is a non persisted field.
	 */
	private List<Child> signUpAlgoList;
	
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

	/**
	 * @return the signUpList
	 */
	@ManyToMany
	@JoinTable(name="groupsignuplist")
	public List<Child> getSignUpList() {
		return signUpList;
	}

	/**
	 * @param signUpList the signUpList to set
	 */
	public void setSignUpList(List<Child> signUpList) {
		this.signUpList = signUpList;
	}
	
	/**
	 * Add a child to the signup list of preferences.
	 * 
	 * @param c
	 */
	public void addSignUpListChild(Child c) {
		if (signUpList == null) {
			signUpList = new ArrayList<Child>();
		}
		
		signUpList.add(c);
	}

	@OneToMany(mappedBy="group")
	public List<User> getEducators() {
		return educators;
	}

	public void setEducators(List<User> educators) {
		this.educators = educators;
	}
	
	/**
	 * @return the records
	 */
	@OneToMany(mappedBy="group")
	public List<ChildRecord> getRecords() {
		return records;
	}

	/**
	 * @param records the records to set
	 */
	public void setRecords(List<ChildRecord> records) {
		this.records = records;
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
	 * @return the signUpAlgoList
	 */
	@Transient
	public List<Child> getSignUpAlgoList() {
		return signUpAlgoList;
	}

	/**
	 * @param signUpAlgoList the signUpAlgoList to set
	 */
	public void setSignUpAlgoList(List<Child> signUpAlgoList) {
		this.signUpAlgoList = signUpAlgoList;
	}
	
	public void addSignUpAlgoChild(Child c) {
		if (signUpAlgoList == null) {
			signUpAlgoList = new ArrayList<Child>();
		}
		
		signUpAlgoList.add(c);
	}
	
	/**
	 * Sorts the {@link #signUpAlgoList} children by priority and then 
	 * by social status. If none of those differ, then there is no defined
	 * behavior.
	 * 
	 * You can get the prioritized children as {@link #getSignUpAlgoList()} with
	 * the first element being the highest priority.
	 */
	public void rankSignUpAlgoChildren() {
		if (signUpAlgoList == null) {
			signUpAlgoList = new ArrayList<Child>();
			return;
		}
		
		if (signUpAlgoList.size() < 2) {
			return;
		}
		
		Collections.sort(this.signUpAlgoList, new SignUpAlgoChildComparator());
	}
	
	/**
	 * Adds children from the {@link #signUpAlgoList} to the list of children in the group.
	 * The children are officially signed.
	 * 
	 * The child will get the group too.
	 */
	public void saveSignUps() {		
		Group me = DAOProvider.getDAO().getGroup(this.id);
		
		List<Child> cldrn = me.getChildren();
		if (cldrn == null) {
			cldrn = new ArrayList<Child>();
		}
		
		for (Child c : cldrn) {
			System.out.println("---" + c.getId()+ " " + c.getFirstName() + " " + c.getLastName());
		}
		
		System.out.println("Group " + me.getId() + ". Saving children: ");

		
		for (Child c : signUpAlgoList) {
			System.out.println("> " + c.getId()+ " " + c.getFirstName() + " " + c.getLastName());
			
			Child sChild = DAOProvider.getDAO().getChild(c.getId());
			System.out.println("> " + sChild.getId()+ " " + sChild.getFirstName() + " " + sChild.getLastName());

			sChild.setGroup(me);
			cldrn.add(sChild);
			me.setChildren(cldrn);
		}
		
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
