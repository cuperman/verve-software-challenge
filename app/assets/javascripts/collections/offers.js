var app = app || {};

(function() {
    "use strict";

    app.Offers = Backbone.Collection.extend({
        model: app.Offer
    });
})();
