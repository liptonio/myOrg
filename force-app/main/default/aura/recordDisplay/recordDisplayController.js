({
    doInit : function(component, event, helper) {

        helper.getAccountList(component);
   
    },
    accountSelected : function(component,event) {  
        var myEvent = $A.get("e.ltng:selectSObject");

        var cmp = event.currentTarget;
        var attribute = cmp.dataset.myvalue;

        var latitude = cmp.dataset.lat;
        var longitude = cmp.dataset.long;
      

        myEvent.setParams({"BillingLatitude": latitude});
        myEvent.setParams({"BillingLongitude": longitude});
        myEvent.setParams({"recordId": attribute});
        console.info(accountName);
        myEvent.fire();
    }
});