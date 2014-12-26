package hr.fer.zemris.opp.model.records;

import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 * Class represents a single record of children that attended ther
 * group at a certain date.
 * 
 * @author domagoj
 *
 */
@Entity
@Table(name="child_record")
public class ChildRecord {

	/**
	 * Unique identifier of the record.
	 */
	private long id;
	
	/**
	 * The date of the record.
	 */
	private Date date;
	
	/**
	 * The group for which the record is filled.
	 */
	private Group group;
	
	/**
	 * The children that were present the given date.
	 */
	private List<Child> presentChildren;

	public ChildRecord() { 
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
	 * @return the date
	 */
	@Column
	public Date getDate() {
		return date;
	}

	/**
	 * @param date the date to set
	 */
	public void setDate(Date date) {
		this.date = date;
	}

	/**
	 * @return the group
	 */
	@ManyToOne
	@JoinColumn(nullable=false)
	public Group getGroup() {
		return group;
	}

	/**
	 * @param group the group to set
	 */
	public void setGroup(Group group) {
		this.group = group;
	}

	/**
	 * @return the presentChildren
	 */
	@ManyToMany
	@JoinTable(name="attended_children")
	public List<Child> getPresentChildren() {
		return presentChildren;
	}

	/**
	 * @param presentChildren the presentChildren to set
	 */
	public void setPresentChildren(List<Child> presentChildren) {
		this.presentChildren = presentChildren;
	}
	
	
}
