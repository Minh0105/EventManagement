//Review Upload
let uploadButton = document.getElementById("upload-button");
let chosenImage = document.getElementById("chosen-image");
let fileName = document.getElementById("file-name");

uploadButton.onchange = () => {
    let reader = new FileReader();
    reader.readAsDataURL(uploadButton.files[0]);
    reader.onload = () => {
        chosenImage.setAttribute("src",reader.result);
    };
    fileName.textContent = uploadButton.files[0].name;
};

//Search
function myFunction() {
    var input, keyword, lecturer_list, txtLecName, txtValue;
    input = document.getElementById("myInput");
    keyword = input.value.toUpperCase().trim();

    lecturer_list = document.getElementsByClassName("lec_item");
    for (var lecItem of lecturer_list) {
        txtLecName = lecItem.getElementsByClassName("lec_name")[0];
        txtValue = txtLecName.textContent || txtLecName.innerText;
        if (txtValue.toUpperCase().trim().includes(keyword)) {
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

}


// CREATE DYNAMIC FORM AND SEND REQUEST
function sendDataToServer () {
    var form = '<form id="submit_form" action="handleMultipart" method="POST" enctype="multipart/form-data">'

        form += createEventDetailParameter();
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
