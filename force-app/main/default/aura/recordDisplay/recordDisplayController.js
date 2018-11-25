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

        var cmp = event.currentTarget;
        
        var attribute = cmp.dataset.myvalue;
        var latitude = cmp.dataset.lat;
        var longitude = cmp.dataset.long;

        myEvent.setParams({"BillingLatitude": latitude});
        myEvent.setParams({"BillingLongitude": longitude});
        myEvent.setParams({"recordId": attribute});
        myEvent.fire();
    }
});