trigger AssignProfileTriggerr on User (after update) {
    AssignCustomProfiles newInstance = new AssignCustomProfiles();
	Set<ID> usersId = new Set<Id>();
	Set<User> usersToClass = new Set<User>();
	for (user c :trigger.new) {
	    if(c.FireTriggerProfile__c == true) {
	       			usersId.add(c.Id);
		}
        

	}

	for (User u : [Select Id,FireTriggerProfile__c FROM User Where Id IN : usersId]){
		usersToClass.add(u);
	    u.FireTriggerProfile__c = false; 	
	}

AssignCustomProfiles.assignProfileToUser(usersToClass);   // blad  Method does not exist or incorrect signature: void assignProfileToUser() from the type AssignCustomProfiles

}