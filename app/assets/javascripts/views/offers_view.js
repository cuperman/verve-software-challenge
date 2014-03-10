var app = app || {};

(function() {
    "use strict";

    app.OffersView = Backbone.Marionette.View.extend({
        templates: {
            tableRowActions: JST["offers/table_row_actions"],
            mapInfoWindow: JST["offers/map_info_window"]
        },

        ui: {
            map: "#map",
            table: ".table-offers",

            uploadButton: ".btn-upload",
            uploadFileInput: "#form-upload [name='file']",
        },

        events: {
            "click @ui.uploadButton": "openFileInput",
            "change @ui.uploadFileInput": "submitUpload"
        },

        initialize: function(options) {
            this.offers = options && options.offers;
            this.verveOffice = options && options.verveOffice;

            this.initializeMap();
            this.listenTo(this, "offers:displayed", this.updateMapMarkers);

            this.initializeTable();
        },

        initializeMap: function() {
            if (this.verveOffice) {
                this.map = new GMaps({
                    div: this.ui.map,
                    lat: this.verveOffice.get("latitude"),
                    lng: this.verveOffice.get("longitude")
                });
            }
        },

        initializeTable: function() {
            if (this.offers) {
                this.table = this.$(this.ui.table).dataTable({
                    sDom: "t<'row'<'col-sm-6'i><'col-sm-6'p>>",
                    sPaginationType: "bootstrap",
                    aaData: this.offers.toJSON(),
                    aoColumns: [
                        { mData: "business_name", sWidth: "20%" },
                        { mData: "address", sWidth: "20%" },
                        { mData: "full_postal_code", sWidth: "12%" },
                        { mData: "latitude", sWidth: "12%" },
                        { mData: "longitude", sWidth: "12%" },
                        {
                            mData: "distance_in_miles",
                            sWidth: "12%",
                            mRender: function(distance, type) {
                                if (type === "display") {
                                    return distance.toFixed(0) + " mi";
                                } else {
                                    return distance;
                                }
                            },
                        },
                        {
                            mData: "id", // used for links
                            sWidth: "12%",
                            bSortable: false,
                            mRender: function(id) {
                                return this.templates.tableRowActions({
                                    id: id
                                });
                            }.bind(this)
                        }
                    ],
                    fnHeaderCallback: function(nHead, aData, iStart, iEnd, aiDisplay) {
                        var displayedOffers = [];
                        if (iEnd > iStart) {
                            for (var i = iStart; i <= iEnd; i++) {
                                displayedOffers.push(aData[aiDisplay[i]]);
                            }
                        }
                        this.trigger("offers:displayed", displayedOffers);
                    }.bind(this),
                    aaSorting: [[ 5, "asc"]]
                });
            }
        },

        updateMapMarkers: function(offers) {
            if (this.map && offers) {
                this.map.removeMarkers();

                _.each(offers, function(offer) {
                    this.map.addMarker({
                        lat: offer.latitude,
                        lng: offer.longitude,
                        title: offer.business_name,
                        infoWindow: {
                            content: this.templates.mapInfoWindow({
                                offer: offer
                            })
                        }
                    });
                }, this);

                if (!_.isEmpty(offers)) {
                    this.map.fitZoom();
                }
            }
        },

        openFileInput: function(ev) {
            ev.preventDefault();

            this.$(this.ui.uploadFileInput).click();

            return false;
        },

        submitUpload: function(ev) {
            ev.preventDefault();

            $(ev.currentTarget).closest("form").submit();

            return false;
        }
    });
})();
