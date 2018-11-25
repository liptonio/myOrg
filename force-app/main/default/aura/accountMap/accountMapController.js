({
    init: function (component, event, helper) {
        component.set('v.mapMarkers', [
            {
                location: {
                    'Latitude': '37.790197',
                    'Longitude': '-122.396879'
                },

                title: 'The White House',
                description: 'Landmark, historic home & office of the United States president, with tours for visitors.'
            }
        ]);
    
        component.set('v.zoomLevel', 3);
    },
    recordChangeHandler : function(component, event) {

        var lang = event.getParam("BillingLatitude");
        var lat = event.getParam("BillingLongitude");
        console.info(lat);

        component.set('v.mapMarkers', [
            {
                location: {
                    'Latitude': lang,
                    'Longitude': lat
                },

                title: 'The White House',
                description: 'Landmark, historic home & office of the United States president, with tours for visitors.'
            }
        ]);

        var Id = event.getParam("recordId");
        console.info(Id);
        component.set("v.recordId", Id);
        var service = component.find("service");
        service.reloadRecord();
	}
})