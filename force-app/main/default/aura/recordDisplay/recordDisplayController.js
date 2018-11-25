({
    doInit : function(component, event, helper) {
        var action = component.get("c.getAccounts");
        action.setCallback(this, function(response){
            var result =response.getReturnValue();
            component.set("v.accounts",result);
        }),
            
            $A.enqueueAction(action);
    },
    accountSelected : function(component,event) {  
        var myEvent = $A.get("e.ltng:selectSObject");

        var adr = component.get("c.getAccounts");

        var cmp = event.currentTarget;
        var attribute = cmp.dataset.myvalue;

        var latitude = cmp.dataset.lat;
        var longitude = cmp.dataset.long;

        console.info(latitude);
        console.info(longitude);
        console.info(attribute);

        
      //  myEvent.setParams({"BillingLatitude": adr.BillingLatitude});
       // myEvent.setParams({"BillingLongitude": adr.BillingLongitude});
        myEvent.setParams({"recordId": attribute});
        myEvent.fire();
    }
});