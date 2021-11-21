//Review Upload
let uploadButton = document.getElementById("upload-button");
let chosenImage = document.getElementById("chosen-image");
let fileName = document.getElementById("file-name");

let chosenLecturerPlaceHolder = document.getElementsByClassName("place_holder")[0];

uploadButton.onchange = () => {
    let reader = new FileReader();
    reader.readAsDataURL(uploadButton.files[0]);
    reader.onload = () => {
        chosenImage.setAttribute("src",reader.result);
    };
    fileName.textContent = uploadButton.files[0].name;
};

//Search
function onSearchLecturerName() {
    var input, keyword, lecturer_list;
    input = document.getElementById("myInput");
    keyword = input.value.toUpperCase().trim();

    if (keyword == "") {
        hideLecturerList();
        return;
    } 

    lecturer_list = document.getElementsByClassName("lec_item");
    for (var lecItem of lecturer_list) {
        var lec = getLecturerInforFromLecItem(lecItem);
        console.log("Lec: " + lec.name);
        var matchName = lec.name.toUpperCase().trim().includes(keyword); 
        var hasNotBeenChosen = checkHasBeenChosen(lec.id) == false;
        if (matchName && hasNotBeenChosen) {
            lecItem.style.display = "flex";
        } else {
            lecItem.style.display = "none";
        }
    }

    if (isAllLecturerDisplayNone()) {
        hideLecturerList();
    } else {
        showLecturerList();
    }
}

function checkHasBeenChosen (lecturerId) {
    var chosenLecturer = document.getElementsByClassName("chosen_lecturer");
    var chosenLecInfor;

    for (var chosenLecItem of chosenLecturer) {
        chosenLecInfor = getLecturer_NameAndId_From_ChosenLecItem(chosenLecItem);
        if (chosenLecInfor.id == lecturerId) {
            return true;
        }        
    }

    return false;
}

function getLecturerInforFromLecItem (lecItem) {
    
    var txtLecName = lecItem.getElementsByClassName("lec_name")[0];
    var lec_name = txtLecName.textContent || txtLecName.innerText;

    var txtLecId = lecItem.getElementsByTagName("input")[0];
    var lec_id = txtLecId.value;
    
    var imgAvatar = lecItem.getElementsByClassName("lec_ava")[0];
    var lec_ava = imgAvatar.getAttribute("src");
    let lecturer = {name : lec_name, id : lec_id, ava : lec_ava};
    return lecturer;
}

function getLecturer_NameAndId_From_ChosenLecItem (lecItem) {
    var txtLecName = lecItem.getElementsByTagName("span")[0];
    var lec_name = txtLecName.textContent || txtLecName.innerText;

    var txtLecId = lecItem.getElementsByClassName("chosen_lecturer_id")[0];
    var lec_id = txtLecId.value;
    
    let lecturer = {name : lec_name, id : lec_id};
    return lecturer;
}


// CHOOSE LECTURER 
function onChooseLecturer(button) {
    // Hide itself
    button.style.display = "none";

    // Extract Lecturer Data
    var lecId = button.getElementsByTagName("input")[0].value;
    var lecName = button.getElementsByClassName("lec_name")[0].innerHTML;

    // Button Model
    var chosen_lec_div = "";
    chosen_lec_div += '<div class="chosen_lecturer"> \n';
    chosen_lec_div += '    <div> \n';
    chosen_lec_div += '        <span class="mr-3">'+lecName+'</span> \n';
    chosen_lec_div += '        <img onclick="onRemoveChosenLecturerClick(\''+lecId+'\', this)" class="btn_remove_lec" style="width: 1rem; height: 1rem;" src="resources/icon/icon_remove_lecturer.svg"> \n';
    chosen_lec_div += '        <input class="chosen_lecturer_id d-none" type="hidden" name="chosen_lecturer" value="'+lecId+'"/> \n';
    chosen_lec_div += '    </div> \n';
    chosen_lec_div += '</div> \n';

    // Add pContainer to Html page
    var chosenLecturerContainer = document.getElementById("chosen_lecturer_container");
    chosenLecturerContainer.appendChild(createNodeFromHtml(chosen_lec_div));

    if (isAllLecturerDisplayNone()) {
        hideLecturerList();
    }

    hideChosenLecturerPlaceHolder();
}

function hideChosenLecturerPlaceHolder () {
    chosenLecturerPlaceHolder.style.display = "none";
}

function showChosenLecturerPlaceHolder () {
    chosenLecturerPlaceHolder.style.display = "flex";
}

function showLecturerList () {
    document.getElementById("floated_lecturer_list").style.display = 'flex';
}

function hideLecturerList () {
    document.getElementById("floated_lecturer_list").style.display = 'none';
}

function isAllLecturerDisplayNone () {
    var lecturer_item = document.getElementsByClassName("lec_item");
    for (var lecturer of lecturer_item) {
        if (lecturer.style.display != "none") {
            return false;
        }
    }

    return true;
}

function createNodeFromHtml (html) {
    var div = document.createElement("div");
    div.innerHTML = html.trim();
    return div.firstChild;
}

function onRemoveChosenLecturerClick(removedLecturerID, button) {
    showLecturerList();
    var grandPa = button.parentNode.parentNode.parentNode;
    grandPa.removeChild(button.parentNode.parentNode);

    var lecturerInforElementList = document.getElementsByClassName("lec_item");

    for (var lecInfor of lecturerInforElementList) {
        var lecInforID = lecInfor.getElementsByTagName("input")[0].value;
        console.log(lecInforID + " and " + removedLecturerID + " = " + (lecInforID == removedLecturerID));
        if (lecInforID == removedLecturerID) {
            lecInfor.style.display = "block";
        }
    }

    var noLecturerChosen = document.getElementsByClassName("chosen_lecturer").length == 0;
    if (noLecturerChosen) {
        showChosenLecturerPlaceHolder();
    }
}


// CREATE DYNAMIC FORM AND SEND REQUEST
function sendDataToServer () {
    var form = '<form id="submit_form" action="handleMultipart" method="POST" enctype="multipart/form-data">'

        var eventContent = createEventDetailParameter();
        if (eventContent == undefined) {
            return;
        }

        form += eventContent;

        form += createChosenLecturerParameter();
        form += createActionParameter();

    form += "</form>"    
    
    var eventImageBackgroundInput = document.getElementById("upload-button").cloneNode();
    eventImageBackgroundInput.style.display = "none";

    document.getElementById("submiter").innerHTML = form;
    document.getElementById("submit_form").appendChild(eventImageBackgroundInput);
    console.log(document.getElementById("submit_form").innerHTML);

    // Trigger send Request
    document.getElementById("submit_form").submit();
}

function sendDataBackToChooseDateTimeLocationPage() {
    var form = '<form id="submit_form_back" action="handleMultipart" method="POST" enctype="multipart/form-data">'

        var eventContent = createEventDetailToBackToChooseDateTimeLocationPage();
        if (eventContent == undefined) {
            return;
        }

        form += eventContent;

        form += createChosenLecturerParameter();

        form += '<input type="hidden" name="action" value="Go back" />\n';
    form += "</form>"    
    
    var eventImageBackgroundInput = document.getElementById("upload-button").cloneNode();
    eventImageBackgroundInput.style.display = "none";

    document.getElementById("submiter").innerHTML = form;
    document.getElementById("submit_form_back").appendChild(eventImageBackgroundInput);
    console.log(document.getElementById("submit_form_back").innerHTML);

    // Trigger send Request
    document.getElementById("submit_form_back").submit();
}

function createChosenLecturerParameter() {
    var htmlContent = "";
    var chosenLecturerElements = document.getElementsByClassName("chosen_lecturer_id");

    for (var chosenLec of chosenLecturerElements) {
        htmlContent += chosenLec.outerHTML + "\n";
    }
    console.log(htmlContent);
    return htmlContent;
}

function createEventDetailParameter() {
    var htmlContent = "";

    var eventName = document.getElementById("input_event_name").value;
    if (eventName.length == 0) {
        window.alert("Tên sự kiện không được để trống");
        return undefined;

    } 
    console.log("HAHA:" + eventName.length)
    if (eventName.length > 99) {
        window.alert("Tên sự kiện không được quá 99 kí tự");
        return undefined;
    }

    var eventNameInput = '<textarea style="display:none;" name="eventName">'+ eventName + '</textarea>';

    var eventDescriptionTest = CKEDITOR.instances.input_event_description.getData();
    
    if (eventDescriptionTest.length == 0) {
        window.alert("Nội dung sự kiện không được để trống");
        return undefined;
    }

    var eventDescriptionInput = '<textarea style="display:none;" name="description">'+ eventDescriptionTest + '</textarea>';

    htmlContent += eventNameInput;
    htmlContent += eventDescriptionInput;

    return htmlContent;
}

function createEventDetailToBackToChooseDateTimeLocationPage(){
    var htmlContent = "";

    var eventName = document.getElementById("input_event_name").value;
    var eventNameInput = '<textarea style="display:none;" name="eventName">'+ eventName + '</textarea>';

    var eventDescriptionTest = CKEDITOR.instances.input_event_description.getData();
    
    var eventDescriptionInput = '<textarea style="display:none;" name="description">'+ eventDescriptionTest + '</textarea>';

    htmlContent += eventNameInput;
    htmlContent += eventDescriptionInput;

    return htmlContent;
}

function createActionParameter () {
    return '<input type="hidden" name="action" value="Review" />\n';
}

function updateNameDescriptionLecturerList(eventId) {
    var eventDescriptionTest = CKEDITOR.instances.input_event_description.getData();
    var eventName = document.getElementById("input_event_name").value;
    var form = document.createElement("form");
    document.body.appendChild(form);
    form.method = "POST";
    form.action = "updateEvent";
    var inputEventId = document.createElement("INPUT");
    inputEventId.name = "eventId";
    inputEventId.value = eventId;
    inputEventId.type = 'hidden'
    form.appendChild(inputEventId);
    var inputEventName = document.createElement("INPUT");
    inputEventName.name = "eventName";
    inputEventName.value = eventName;
    inputEventName.type = 'hidden';
    form.appendChild(inputEventName);
    var inputDescription = document.createElement("INPUT");
    inputDescription.name = "description";
    inputDescription.value = eventDescriptionTest;
    inputDescription.type = 'hidden';
    form.appendChild(inputDescription);
    
   //var inputChosenLecturer = document.querySelectorAll('input[name="chosen_lecturer"]');
   var inputChosenLecturer = document.getElementsByClassName("chosen_lecturer_id");
   for(var inputLecturer of inputChosenLecturer){
       console.log(inputLecturer);
       form.appendChild(inputLecturer);
   }
   form.submit();
}