({
	getAccountList : function(component) {
			var action = component.get("c.getAccounts");
			action.setCallback(this, function(response){
				var result =response.getReturnValue();
				component.set("v.accounts",result);
			}),
				
				$A.enqueueAction(action);
		}
	
})