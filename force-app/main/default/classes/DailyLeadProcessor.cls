global class DailyLeadProcessor implements Schedulable{
    
    global void execute(SchedulableContext ctx) {
        
        List<Lead> led = [Select Name,LeadSource from Lead where LeadSource=NULL LIMIT 200];
        
        For(Lead l : led) {
        l.LeadSource='DreamForce';  
        }
        update led;
}
}