package hr.fer.zemris.opp.model;

import java.util.Comparator;

public class SignUpAlgoChildComparator implements Comparator<Child> {

	/**
	 * Compares two {@link Child} objects for the ranking algorithm.
	 * 
	 * An object is considered "bigger than" (returning 1) when
	 * it has bigger priority in the list.
	 */
	@Override
	public int compare(Child c1, Child c2) {
		if (c1.getPriority() > c2.getPriority()) {
			return 1;
		}
		
		if (c2.getPriority() > c1.getPriority()) {
			return -1;
		}
		
		Parent p1 = c1.getParent();
		Parent p2 = c2.getParent();
		if (p1.getSocialStatus() == 1 && p2.getSocialStatus() == 1) {
			if (p1.getIncome() < p2.getIncome()) {
				return 1;
			}
			
			if (p1.getIncome() > p2.getIncome()) {
				return -1;
			}
			
			return 0;
		}
		
		if (p1.getSocialStatus() == 1) {
			return 1;
		}
		
		if (p2.getSocialStatus() == 1) {
			return -1;
		}
		
		return 0;
	}

}
