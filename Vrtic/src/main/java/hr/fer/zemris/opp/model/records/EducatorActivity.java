package hr.fer.zemris.opp.model.records;

import java.util.Date;

import hr.fer.zemris.opp.model.users.User;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="educatorActivity")
public class EducatorActivity {

	/**
	 * Unique id of the activity.
	 */
	private long id;
	
	/**
	 * The date the activity has been made.
	 */
	private Date date;
	
	/**
	 * The work hours put into effective work.
	 */
	private int workHour_eW;
	
	/**
	 * The work hours put into work preparation.
	 */
	private int workHour_wP;
	
	/**
	 * The work hours put into specialization.
	 */
	private int workHour_s;
	
	/**
	 * The work hours put into work with parents.
	 */
	private int workHour_pW;
	
	/**
	 * The text/description that is added to the educators activity.
	 */
	private String effectiveWork;
	
	/**
	 * The text/description that is added to the educators activity.
	 */
	private String workPreparation;
	
	/**
	 * The text/description that is added to the educators activity.
	 */
	private String specialization;
	
	/**
	 * The text/description that is added to the educators activity.
	 */
	private String parentWork;
	
	/**
	 * The educator whose activity is saved.
	 */
	private User educator;
	
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
	 * @param date2 the date to set
	 */
	public void setDate(Date date2) {
		this.date = date2;
	}
	
	/**
	 * @return the workHour_eW
	 */
	@Basic
	public int getWorkHour_eW() {
		return workHour_eW;
	}

	/**
	 * @param workHour_eW the workHour_eW to set
	 */
	public void setWorkHour_eW(int workHour_eW) {
		this.workHour_eW = workHour_eW;
	}

	/**
	 * @return the workHour_wP
	 */
	@Basic
	public int getWorkHour_wP() {
		return workHour_wP;
	}

	/**
	 * @param workHour_wP the workHour_wP to set
	 */
	public void setWorkHour_wP(int workHour_wP) {
		this.workHour_wP = workHour_wP;
	}

	/**
	 * @return the workHour_s
	 */
	@Basic
	public int getWorkHour_s() {
		return workHour_s;
	}

	/**
	 * @param workHour_s the workHour_s to set
	 */
	public void setWorkHour_s(int workHour_s) {
		this.workHour_s = workHour_s;
	}

	/**
	 * @return the workHour_pW
	 */
	@Basic
	public int getWorkHour_pW() {
		return workHour_pW;
	}

	/**
	 * @param workHour_pW the workHour_pW to set
	 */
	public void setWorkHour_pW(int workHour_pW) {
		this.workHour_pW = workHour_pW;
	}

	/**
	 * @return the educator
	 */
	@ManyToOne
	@JoinColumn(nullable=false)
	public User getEducator() {
		return educator;
	}

	/**
	 * @param educator the educator to set
	 */
	public void setEducator(User educator) {
		this.educator = educator;
	}

	/**
	 * @return the efectiveWork
	 */
	@Basic
	public String getEffectiveWork() {
		return effectiveWork;
	}

	/**
	 * @param efectiveWork the efectiveWork to set
	 */
	public void setEffectiveWork(String efectiveWork) {
		this.effectiveWork = efectiveWork;
	}

	/**
	 * @return the workPreparation
	 */
	@Basic
	public String getWorkPreparation() {
		return workPreparation;
	}

	/**
	 * @param workPreparation the workPreparation to set
	 */
	public void setWorkPreparation(String workPreparation) {
		this.workPreparation = workPreparation;
	}

	/**
	 * @return the specialization
	 */
	@Basic
	public String getSpecialization() {
		return specialization;
	}

	/**
	 * @param specialization the specialization to set
	 */
	public void setSpecialization(String specialization) {
		this.specialization = specialization;
	}

	/**
	 * @return the parentWork
	 */
	@Basic
	public String getParentWork() {
		return parentWork;
	}

	/**
	 * @param parentWork the parentWork to set
	 */
	public void setParentWork(String parentWork) {
		this.parentWork = parentWork;
	}
	
}
