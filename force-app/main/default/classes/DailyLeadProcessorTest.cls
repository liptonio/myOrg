@isTest
public class DailyLeadProcessorTest {
    
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    static testmethod void testScheduledJob() {
        
Lead[] l = new List<Lead>();
        
    for (Integer i=0; i<200;i++) {
       Lead lp = new Lead(Lastname='cos'+i,Company='asd',Status='Working - Contacted');
        l.add(lp);
    }
                
    insert l;
        Test.startTest();
        string jobId = System.schedule('testScheduledJob',CRON_EXP, new DailyLeadProcessor());         
        Test.stopTest();
          }
    
}