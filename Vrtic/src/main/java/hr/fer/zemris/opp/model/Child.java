package hr.fer.zemris.opp.model;

import hr.fer.zemris.opp.model.records.ChildRecord;
import hr.fer.zemris.opp.model.records.PaymentRecord;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 * A child in the system.
 * 
 * @author domagoj
 *
 */
@Entity
@Table(name="children")
public class Child {

	/**
	 * Unique identifier.
	 */
	private long id;
	
	/**
	 * First name of the child.
	 */
	private String firstName;
	
	/**
	 * Child's last name.
	 */
	private String lastName;
	
	/**
	 * Child's OIB number.
	 */
	private String oib;
	
	/**
	 * The childs parent.
	 */
	private Parent parent;
	
	/**
	 * The sex of the child.
	 */
	private String sex;
	
	/**
	 * Childs birthdate.
	 */
	private Date birthdate;
	
	/**
	 * Priority in the queque.
	 */
	private byte priority;
	
	/**
	 * Group that this child belongs too.
	 */
	private Group group = null;
	
	/**
	 * The list of groups that the child wants to join if he isn't
	 * in a group yet. The list is ordered by priority of 
	 * the groups he wants to joining with the group at index 0 having
	 * the biggest priority.
	 */
	private List<Group> signUpGroups = new ArrayList<Group>();
	
	/**
	 * All of the attendance records for this child.
	 */
	private List<ChildRecord> records = new ArrayList<ChildRecord>();
	
	/**
	 * List of all payment records for the child i.e. all the months that have been payed.
	 */
	private List<PaymentRecord> paymentRecords = new ArrayList<PaymentRecord>();
	
	public Child() {
	}

	@Id @GeneratedValue
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@Column(length=40, nullable=false)
	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	@Column(length=40, nullable=false)
	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	@Column(length=40, nullable=false)
	public String getOib() {
		return oib;
	}
	
	public void setOib(String oib) {
		this.oib = oib;
	}

	@ManyToOne
	@JoinColumn(nullable=false)
	public Parent getParent() {
		return parent;
	}

	public void setParent(Parent parent) {
		this.parent = parent;
	}

	@Column(length=1, nullable=false)
	public String getSex() {
		return sex;
	}

	/**
	 * The sex of the child.
	 * Can only be "M" or "F". Throws {@link IllegalArgumentException} if not.
	 * 
	 * @param sex of the child, can only be "M" or "F".
	 * @throws IllegalArgumentException on bad argument
	 */
	public void setSex(String sex) throws IllegalArgumentException {
		this.sex = sex;
	}

	@Column
	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	@Basic
	public byte getPriority() {
		return priority;
	}

	public void setPriority(byte priority) {
		this.priority = priority;
	}

	@ManyToOne
	public Group getGroup() {
		return group;
	}

	public void setGroup(Group group) {
		this.group = group;
	}
	
	/**
	 * @return the signUpList
	 */
	@ManyToMany(mappedBy="signUpList")
	public List<Group> getSignUpGroups() {
		return signUpGroups;
	}

	/**
	 * @param signUpList the signUpList to set
	 */
	public void setSignUpGroups(List<Group> signUpList) {
		this.signUpGroups = signUpList;
	}

	/**
	 * @return the records
	 */
	@ManyToMany(mappedBy="presentChildren")
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
	 * Add a record to the {@link ChildRecord} list.
	 * 
	 * @param record to add
	 */
	public void addRecord(ChildRecord record) {
		if (record == null) {
			records = new ArrayList<ChildRecord>();
		}
		
		records.add(record);
	}

	/**
	 * @return the paymentRecords
	 */
	@OneToMany(fetch=FetchType.LAZY, mappedBy="child",  cascade=CascadeType.ALL, orphanRemoval=true)
	public List<PaymentRecord> getPaymentRecords() {
		return paymentRecords;
	}

	/**
	 * @param paymentRecords the paymentRecords to set
	 */
	public void setPaymentRecords(List<PaymentRecord> paymentRecords) {
		this.paymentRecords = paymentRecords;
	}
	
	/**
	 * Add a record to the {@link PaymentRecord} list.
	 * 
	 * @param record to add
	 */
	public void addPaymentRecord(PaymentRecord record) {
		if (paymentRecords == null) {
			paymentRecords = new ArrayList<PaymentRecord>();
		}
		
		paymentRecords.add(record);
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
		Child other = (Child) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	
}
