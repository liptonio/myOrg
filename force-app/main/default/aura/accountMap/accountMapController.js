({
    init: function (component, event, helper) {
        component.set('v.mapMarkers', [
            {
                location: {
                    'Latitude': component.get("v.BillingLatitude"),
                    'Longitude': component.get("v.BillingLongitude")
                },

                title: 'The White House',
                description: 'Landmark, historic home & office of the United States president, with tours for visitors.'
            }
        ]);
        component.set('v.zoomLevel', 1);
    }
})