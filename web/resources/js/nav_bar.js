
$('#nav_expanded_panel').hide();

$('#btn_menu').click(function () {
    if ($('#nav_expanded_panel').css("display") == "none") {
        $('#nav_expanded_panel').show();
    } else {
        $('#nav_expanded_panel').hide();
    }
});

$('#btn_bell').click (function () {
    if ($('#notification_board').css("display") == "none") {
        $('#notification_board').show();
        seenAllNotification();
    } else {
        $('#notification_board').hide();
        resetAllSeenState();
    }
})
