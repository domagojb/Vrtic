package hr.fer.zemris.opp.model;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.dao.jpa.JPAEMProvider;

import java.util.ArrayList;
import java.util.List;

/**
 * Class represents the sign up algorithm process.
 * 
 * @author domagoj
 *
 */
public class SignUpAlgorithm implements Runnable {
	
	@Override
	public void run() {
		System.out.println("Starting sign up algorithm");
		System.out.println("Gathering all children open for sign up");
		
		List<Child> children = DAOProvider.getDAO().getChildrenNoGroup();
		List<Group> groups = DAOProvider.getDAO().getAllGroups();
		
		/*
		 * Represents the step of the algorithm, or rather the number
		 * of the group in the selected priority list for each child.
		 */
		int step = 0; 		
		
		System.out.println("Initializing sign up lists");
		/*
		 * Initialization
		 */
		for (Child child : children) {
			Group childPreference = child.getSignUpGroups().get(step);
			for (Group group : groups) {
				if (childPreference.equals(group)) {
					group.addSignUpAlgoChild(child);
				}
			}
		}
		
		/*
		 * Sorting, ranking mumbo jumbo.
		 */
		System.out.println("Starting sort and rang algoritm");
		while(true) {
			System.out.println("Sorting children in sign up lists for each group");
			System.out.println("Simultaniously retrieving list of children that didn't make the cut");

			children.clear();

			boolean hasSpace = false; // do any groups have any more room
			for (Group group : groups) {
				group.rankSignUpAlgoChildren();
				
				List<Child> tempChildren = group.getSignUpAlgoList();
				
				
				int space = group.getCapacity() - group.count(); // number of children that fit in the group				
				int cut = tempChildren.size() - space;
				
				for(int i = 0; i < cut; i++) {
					children.add(tempChildren.get(space));
					tempChildren.remove(space);
				}
				
				if (space > 0) {
					hasSpace = true;
				}
			}
			
			if (children.isEmpty()) {
				System.out.println("All children signed.");
				break;
			}
			
			if (hasSpace == false) {
				System.out.println("No more room in any group.");
				break;
			}
			
			System.out.println("Incrementing step of algorithm");
			System.out.println("Trying to sign up other children to next preference group");
			step++;
			boolean foundShuffle = false; // could any child shuffle into other group, if no, there are no changes to the algo
			for (Child child : children) {
				List<Group> prefs = child.getSignUpGroups();
				if (prefs.size() <= step) {
					continue;
				}
				
				foundShuffle = true;
				
				Group pref = prefs.get(step);
				for (Group group : groups) {
					if (pref.equals(group)) {
						group.addSignUpAlgoChild(child);
					}
				}
			}
			
			if (foundShuffle == false) {
				System.out.println("No more shuffling steps/no more preferences");
				break;
			}
			
		}
		
		System.out.println("Incrementing all childrens priorities that didn't make the cut");
		System.out.println("Children that didn't make it");
		for (Child c : children) {
			System.out.println("> " + c.getFirstName() + " " + c.getLastName());
			c.setPriority((byte)(c.getPriority()+1));
		}
		
		System.out.println("Saving all children that made the cut");
		
		for (Group g : groups) {
			g.saveSignUps();
		}
		
		JPAEMProvider.close();

		System.out.println("Done");
	}
	
}
