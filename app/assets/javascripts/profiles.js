$(document).ready(function () {
    $(".edit-button").click(function (e) {
        var userToEditId = $(e.currentTarget).data().value;
        $("#id").val(userToEditId)
    });
});

