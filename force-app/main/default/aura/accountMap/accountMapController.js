({
    init: function (cmp, event, helper) {
        cmp.set('v.mapMarkers', [
            {
                location: {
                    'Latitude': component.get("v.BillingLatitude"),
                    'Longitude': component.get("v.BillingLongitude")
                },

                title: 'The White House',
                description: 'Landmark, historic home & office of the United States president, with tours for visitors.'
            }
        ]);
        cmp.set('v.zoomLevel', 1);
    }
})