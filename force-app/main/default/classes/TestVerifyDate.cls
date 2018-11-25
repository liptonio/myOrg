@isTest public class TestVerifyDate {


    @isTest static void testp2() {
        date zmienna = Date.newInstance(2017,06,26);
        Date data1 = VerifyDate.CheckDates(date.today(),zmienna);
        System.assertEquals(zmienna,data1); 
    }
    
   @isTest static void testd3() {
        date zmienna1 = Date.newInstance(2009,11,12);
        Date data2 = VerifyDate.CheckDates(date.today(),zmienna1);
        System.assertEquals(Date.newInstance(date.today().year(),date.Today().month(),(Date.daysInMonth(date.today().year(), date.Today().month()))),data2 );
    }     
       static testMethod void TestVerifyDate() {
      VerifyDate.CheckDates(System.today(),System.today().addDays(10));
       VerifyDate.CheckDates(System.today(),System.today().addDays(78));
    }
}