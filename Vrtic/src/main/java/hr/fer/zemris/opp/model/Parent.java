package hr.fer.zemris.opp.model;

import java.util.List;

public class Parent {

	private long id;
	
	private String firstName;
	
	private String lastName;
	
	private String oib;
	
	private String phone;
	
	private int income;
	
	private int socialStatus;
	
	private List<Child> children;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getOib() {
		return oib;
	}

	public void setOib(String oib) {
		this.oib = oib;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getIncome() {
		return income;
	}

	public void setIncome(int income) {
		this.income = income;
	}

	public int getSocialStatus() {
		return socialStatus;
	}

	public void setSocialStatus(int socialStatus) {
		this.socialStatus = socialStatus;
	}

	public List<Child> getChildren() {
		return children;
	}

	public void setChildren(List<Child> children) {
		this.children = children;
	}
	
	
}
