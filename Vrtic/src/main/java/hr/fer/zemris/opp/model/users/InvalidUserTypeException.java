package hr.fer.zemris.opp.model.users;

public class InvalidUserTypeException extends RuntimeException {
	
	public InvalidUserTypeException() {
		super();
	}
	
	public InvalidUserTypeException(String msg) {
		super(msg);
	}
}
