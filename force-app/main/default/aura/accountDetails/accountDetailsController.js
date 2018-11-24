({
	recordChangeHandler : function(component, event) {
        var Id = event.getParam("recordId");
        component.set("v.recordId", Id);
        var service = component.find("service");
        service.reloadRecord();
	},
    redirectToSobject: function (component, event, helper) {
    var navEvt = $A.get("e.force:navigateToSObject");
    var Id = component.get("v.recordId");
    navEvt.setParams({
      "recordId": Id,
      "slideDevName": "Detail" 
    });
    navEvt.fire();
}
})