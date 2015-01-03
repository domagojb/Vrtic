package hr.fer.zemris.opp.model.records;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import hr.fer.zemris.opp.model.Child;

/** 
 * Represents a month and year combination which
 * has been payed for the child.
 * 
 * @author domagoj
 *
 */
@Entity
@Table(name="paymentRecord")
public class PaymentRecord {

	/**
	 * Unique id of the record.
	 */
	private long id;
	
	/**
	 * Month for which the payment was made.
	 */
	private int month;
	
	/**
	 * Year for which the payment was made.
	 */
	private int year;
	
	/**
	 * The child for whom the payment was made.
	 */
	private Child child;
	
	/**
	 * Do you really need to read this?
	 */
	public PaymentRecord() {
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
	 * @return the month
	 */
	@Basic
	public int getMonth() {
		return month;
	}

	/**
	 * Month must be in the interval from 1 to 12, edges included.
	 * 
	 * If the month is not in the interval, an exception will be raised.
	 * 
	 * @param month the month to set
	 * @throws IllegalArgumentException on month not in defined interval
	 */
	public void setMonth(int month) throws IllegalArgumentException {
		if (month < 1 || month > 12) {
			throw new IllegalArgumentException("Month not in allowed interval 1-12; Got: " + month);
		}
		
		this.month = month;
	}

	/**
	 * @return the year
	 */
	@Basic
	public int getYear() {
		return year;
	}

	/**
	 * @param year the year to set
	 */
	public void setYear(int year) {
		this.year = year;
	}

	/**
	 * @return the child
	 */
	@ManyToOne
	public Child getChild() {
		return child;
	}

	/**
	 * @param child the child to set
	 */
	public void setChild(Child child) {
		this.child = child;
	}
	
}
