$(document).ready(function (){
    AlertSave();

    $('#vote-up').click(
        function () {
            AlertSave();
        }
    );

    $('#vote-down').click(
        function () {
            AlertSave();
        }
    );
});

function AlertSave() {
    alert("Alert Message OnClick");
}