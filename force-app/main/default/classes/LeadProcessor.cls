global class LeadProcessor implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getqueryLocator('SELECT ID,Name,LeadSource from Lead'
    );
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope){
      List<Lead> ListaLEAD = new List<Lead>(); 
        for (Lead leads : scope) {
            leads.Leadsource = 'Dreamforce';
            
            ListaLEAD.add(leads);
        }
        update ListaLEAD;
    }    

    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations 
    }    

}