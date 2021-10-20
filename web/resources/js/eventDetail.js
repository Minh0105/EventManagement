
function showReplyBox (replyButton) {
    var replyBox = replyButton.parentNode.parentNode.parentNode.getElementsByClassName("reply_box")[0];
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
    var replyBox = hideReplyButton.parentNode.parentNode.parentNode.getElementsByClassName("reply_box")[0];
    var replyButton = hideReplyButton.parentNode.parentNode.getElementsByClassName("btn_show_reply")[0];
    replyButton.style.display = "block";
    replyBox.style.display = "none";
}