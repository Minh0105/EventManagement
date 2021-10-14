
function showReply (replyButton) {
    var replyBox = replyButton.parentNode.getElementsByClassName("reply_box")[0];
    replyButton.style.display = "none";
    replyBox.style.display = "block";
}