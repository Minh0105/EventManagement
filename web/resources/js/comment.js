/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


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
  
function banComment(cmtId) {
    
    var updateComment = {};
    updateComment['comments/' + cmtId + '/statusId'] = 'DA';
    database.ref().update(updateComment);
}

function banReply(cmtId, replyId) {
    
    var updateReply = {};
    updateReply['comments/' + cmtId + '/replyList/' + replyId + '/statusId'] = 'DA';
    database.ref().update(updateReply);
}