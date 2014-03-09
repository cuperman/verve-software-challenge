/* global QUnit, module, asyncTest, expect, ok, start, equal */

(function() {
    "use strict";

    // order matters
    QUnit.config.reorder = false;

    var csrfToken = $("meta[name='csrf-token']").attr("content");

    var testOffer = {
        business_name: "Caribou Coffee",
        address_1: "100 5th St",
        postal_code: 55402,
        latitude: 44.978348,
        longitude: -93.268623,
        radius: 5
    };

    var balboaPark = {
        latitude: 32.7341479,
        longitude: -117.14455299999997
    };

    module("Offers");

    asyncTest("Create Offer", function() {
        expect(3);

        $.ajax({
            type: "POST",
            dataType: "json",
            url: "/offers",
            data: {
                authenticity_token: csrfToken,
                offer: testOffer
            }
        })
        .done(function(offer) {
            ok(true, "it should be successful");
            ok(_.isObject(offer), "it should return an offer object");
            ok(offer.id, "the offer object should have an id");

            testOffer.id = offer.id; // save the id for following tests
        })
        .always(start);
    });

    asyncTest("Get Offer", function() {
        expect(9);

        $.ajax({
            type: "GET",
            dataType: "json",
            url: "/offers/" + testOffer.id
        })
        .done(function(offer) {
            ok(true, "it should be successful");
            ok(_.isObject(offer), "it should return an offer object");

            equal(offer.id, testOffer.id, "offer.id should match");
            equal(offer.business_name, testOffer.business_name, "offer.business_name should match");
            equal(offer.address_1, testOffer.address_1, "offer.address_1 should match");
            equal(offer.postal_code, testOffer.postal_code, "offer.postal_code should match");
            equal(offer.latitude, testOffer.latitude, "offer.latitude should match");
            equal(offer.longitude, testOffer.longitude, "offer.longitude should match");
            equal(offer.radius, testOffer.radius, "offer.radius should match");
        })
        .always(start);
    });

    asyncTest("Get Offers", function() {
        expect(3);

        $.ajax({
            type: "GET",
            dataType: "json",
            url: "/offers/"
        })
        .done(function(offers) {
            ok(true, "it should be successful");
            ok(_.isArray(offers), "it should return an array of offers");
            ok(_.findWhere(offers, { id: testOffer.id }), "it should contain the offer we created");
        })
        .always(start);
    });

    asyncTest("Get Offers near a location", function() {
        expect(3);

        $.ajax({
            type: "GET",
            dataType: "json",
            url: "/offers/",
            data: {
                longitude: balboaPark.latitude,
                latitude: balboaPark.longitude
            }
        })
        .done(function(offers) {
            ok(true, "it should be successful");
            ok(_.isArray(offers), "it should return an array of offers");
            ok(_.findWhere(offers, { id: testOffer.id }), "it should contain the offer we created");
        })
        .always(start);
    });

    asyncTest("Update Offer", function() {
        expect(1);

        var offer = _.chain({})
            .extend(testOffer, { business_name: "New Business Name" })
            .omit("id")
            .value();

        $.ajax({
            type: "PUT",
            dataType: "json",
            url: "/offers/" + testOffer.id,
            data: {
                authenticity_token: csrfToken,
                offer: offer
            }
        })
        .done(function() {
            ok(true, "it should be successful");
        })
        .always(start);
    });

    asyncTest("Delete Offer", function() {
        expect(1);

        $.ajax({
            type: "DELETE",
            dataType: "json",
            url: "/offers/" + testOffer.id,
            data: {
                authenticity_token: csrfToken
            }
        })
        .done(function() {
            ok(true, "it should be successful");
        })
        .always(start);
    });
})();
