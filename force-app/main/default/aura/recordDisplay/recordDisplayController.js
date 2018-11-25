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
        // standard event to pass record Id
        var myEvent = $A.get("e.ltng:selectSObject");
        var cmp = event.currentTarget;
        var attribute = cmp.dataset.myvalue;
        myEvent.setParams({"recordId": attribute});

        myEvent.fire();
        // custom application event called c:positionEvent
        var appEvent = $A.get("e.c:positionEvent");
        var latitude = cmp.dataset.lat;
        var longitude = cmp.dataset.long;

        appEvent.setParams({"BillingLatitude": latitude});
        appEvent.setParams({"BillingLongitude": longitude});
        
        appEvent.fire();
    }
});