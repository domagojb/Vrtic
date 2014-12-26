package hr.fer.zemris.opp.model.users;

/**
 * Exception thrown by {@link User#FillAttendanceRecord(javax.servlet.http.HttpServletRequest)}
 * when there is an error in the form.
 * 
 * @author domagoj
 *
 */
public class FormException extends RuntimeException {

	public FormException(String string) {
		super(string);
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = -79927149797496083L;

}
