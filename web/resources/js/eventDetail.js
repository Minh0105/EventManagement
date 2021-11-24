
function showReplyBox (replyButton) {
    var replyBox = replyButton.parentNode.parentNode.parentNode.getElementsByClassName("reply_box")[0];
    replyButton.style.display = "none";
    replyBox.style.display = "block";

    hideOtherReplyBox(replyBox);
}

function showAnswerReplyBox (replyButton) {
    var replyBox = replyButton.parentNode.parentNode.parentNode.parentNode.getElementsByClassName("reply_box")[0];
    replyButton.style.display = "none";
    replyBox.style.display = "block";

    hideOtherReplyBox(replyBox);
}


function hideOtherReplyBox (focusedReplyBox) {
    var replyBox_list = document.getElementsByClassName("reply_box")
    
    for (var item of replyBox_list) {
        if (item != focusedReplyBox) {
            item.style.display = "none";
            item.parentNode.getElementsByClassName("btn_show_reply")[0].style.display = "block";
        }
    }
}


function hideReplyBox (hideReplyButton) {
    var replyBox = hideReplyButton.parentNode;
    var replyButton = hideReplyButton.parentNode.parentNode.getElementsByClassName("btn_show_reply")[0];
    replyButton.style.display = "block";
    replyBox.style.display = "none";
}


// EVENT OPERATION MENU

$('#menu_container').hide();
function onMenuIconClick () {
    if ($('#menu_container').css("display") == "none") {
        $('#menu_container').show();
        document.getElementById('btn_add_summary').scrollIntoView({ behavior: 'smooth', block: 'center'});
    } else {
        $('#menu_container').hide();
        resetMenu();
    }
}


// EDIT EVENT DETAIL

$("#btn_edit_event_details").click(showEditEventDetail_Buttons);

function showEditEventDetail_Buttons () {
    if ($(".menu_sub_button").css("display") == "none") {
        $(".menu_button").hide();
        $(".menu_sub_button").show();
        $("#btn_edit_event_details").show();
    } else {
        resetMenu();
    }
}

function resetMenu () {
    $(".menu_sub_button").hide();
    $(".menu_button").show();
}

// UPDATE EVENT DETAIL

$("#btn_update_event_status").click(function () {
    $('#menu_container').hide();
    resetMenu();
})


function waitingForSubmit (button) {
    button.disabled=true;
    button.value='Submitting...'; 
    button.form.submit();
}

var body = document.getElementById("html_body");
var memberList = document.getElementById("member_list");
var eventContent = document.getElementById("content");

function showMemberList () {
    memberList.style.display = "block";
    eventContent.style.display = "none";
    body.style.backgroundColor = "white !important";
    $('#menu_container').hide();
    resetMenu();
    document.getElementById('scroll_target_title').scrollIntoView({ behavior: 'smooth', block: 'start'});
}

function goBackToContent () {
    if (memberList.style.display != "none") {
        memberList.style.display = "none";
        eventContent.style.display = "block";
        body.style.backgroundColor = "#F0F0F0 !important";
    }
}

$optionMenu = $("#export_option_menu");
$optionMenu.hide();
$("#btn_export_excel").click(function () {
    if ($optionMenu.css("display") == "none") {
        $optionMenu.show();
    } else {
        $optionMenu.hide();
    }
});


function confirmDeleteQuestion (button) {
    if (window.confirm("Bạn muốn xóa câu hỏi này?")) {
        var deleteLink = button.parentNode.getElementsByTagName("a")[0].click();
        deleteLink.click();
    }
}


