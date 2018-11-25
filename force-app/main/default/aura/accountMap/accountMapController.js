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

        var Id = event.getParam("recordId");
        component.set("v.recordId", Id);
        var service = component.find("service");
        service.reloadRecord();
    },
    recordChangeMarker : function(component,event) {
        var lat = event.getParam("BillingLatitude");
        var lang = event.getParam("BillingLongitude");
        console.info(lat);
        console.info(lang);
        component.set('v.mapMarkers', [
            {
                location: {
                    'Latitude': lat,
                    'Longitude': lang
                },

                title: 'The White House',
                description: 'Landmark, historic home & office of the United States president, with tours for visitors.'
            }
        ]);
    }
})