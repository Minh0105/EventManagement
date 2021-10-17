// function sendMsg(frm) {
//   //get message
//   var msg = frm.value;
//   //add new data to firebase location
//   ref.push({ time: new Date().toUTCString(), msg: msg });
//   //clear input text
//   frm.value = "";
// }
 function sendReply(cmtID) {
    
     // reply object 
     var id;
     var contents;
     var userId;
     var userAvatar;
     var userName;
     var userRoleName;
     var replyDatetime;
     var statusId;
    
     cmtRef.child(cmtID+'/replyList').push({  id:id, 
                 contents: contents, 
                 userId:userId, 
                 userAvatar:userAvatar, 
                 userName:userName, 
                 userRoleName:userRoleName,
                 replyDatetime:  replyDatetime,
                 statusId : statusId 
             });
 }

 function sendCmt(frm) { // return the id of comment in firebase, need for reply
     var commentID = frm.commentID.value;
     var contents = frm.contents.value;
     var username = frm.userName.value;
     
     var newCmt = cmtRef.push({
         commentID:commentID,
         contents:contents,
         username:username
     });

     frm.commentID.value = "";
     frm.contents.value = "";
     frm.userName.value = "";

     document.getElementById('cmtID').value = newCmt.key;
 }


// var ref = new Firebase(
//   "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/comments"
// );




  // Import the functions you need from the SDKs you need
  // TODO: Add SDKs for Firebase products that you want to use
  // https://firebase.google.com/docs/web/setup#available-libraries

  // Your web app's Firebase configuration
  const firebaseConfig = {
    apiKey: "AIzaSyCx4WEvFkJXvXVe0ojOiQmjw7-xFkTgYlQ",
    authDomain: "react-getting-started-30bc6.firebaseapp.com",
    databaseURL: "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/",
    projectId: "react-getting-started-30bc6",
    storageBucket: "react-getting-started-30bc6.appspot.com",
    messagingSenderId: "91900710322",
    appId: "1:91900710322:web:6330f47698f45959b068ab"
  };

  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  var database = firebase.database();
  var cmtRef = database.ref('comments');

  cmtRef.orderByChild('username').equalTo('Duong').on("child_added", function (snapshot) {
    //We'll fill this in later.
    var message = snapshot.val();
    $("#messages").append(
      $("<div/>")
        .css({ border: "1px solid red" })
        .html(JSON.stringify(message['username'] + " : " + message['contents']))
    );
  });
