trigger ClosedOpportunityTrigger on Opportunity (before insert) {
    
    

    List<Task> newopp = new List<Task>();
    

    for (Opportunity o : Trigger.new) {
        
        
         if(o.StageName=='Closed Won'){
        
         newopp.add(new Task(Subject='Follow Up Test Task'));
    }
    
    }
    insert newopp;
}