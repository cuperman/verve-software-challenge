(function() {
    "use strict";

    var ui = {
        uploadButton: ".btn-upload",
        uploadFormFileInput: "#form-upload [name='file']"
    };

    var emitter = $({}); // using a jQuery object as an event emitter

    var triggerReady = function() {
        emitter.trigger("ready");
    };

    $(emitter).on("ready", function() {
        // open the file input when upload button is clicked
        $(ui.uploadButton).click(function() {
            $(ui.uploadFormFileInput).click();
        });

        // submit the form when file is chosen
        $(ui.uploadFormFileInput).change(function() {
            $(this).closest("form").submit();
        });
    });

    // trigger ready event when page is loaded or reloaded
    $(document).ready(triggerReady);
    $(document).on("page:load", triggerReady);
})();
