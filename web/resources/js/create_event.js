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
    var input, filter, ul, li, a, i, txtValue;
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase();
    ul = document.getElementById("myUL");
    li = ul.getElementsByTagName("li");
    for (i = 0; i < li.length; i++) {
        a = li[i].getElementsByTagName("button")[0];
        txtValue = a.textContent || a.innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            li[i].style.display = "";
        } else {
            li[i].style.display = "none";
        }
    }
}


// CHOOSE LECTURER 
function onChooseLecturer(button) {
    // Hide itself
    button.parentNode.style.display = "none";

    // Extract Lecturer Data
    var lecId = button.value;
    var lecAvatar = button.getElementsByClassName("lec-avatar")[0].src;
    var lecName = button.getElementsByClassName("lec_name")[0].innerHTML;

    // Button Model
    // <p>
    //         <img class="rounded-circle lec-avatar " src="${lec.avatar}"> 
    //         <span>${lec.name}</span>
    //         <button onclick="onRemoveChosenLecturerClick(this)" name="removeLec">X</button>
    //         <input class="chosen_lecturer" type="hidden" value="${lec.id}"/>
    // </p>

    // Create Chosen Lecturer ELement
    var pContainer = document.createElement("p");

    var imgAvatar = document.createElement("img");
    imgAvatar.className = "rounded-circle lec-avatar";
    imgAvatar.src = lecAvatar;

    var spanName = document.createElement("span");
    spanName.innerHTML = lecName;

    var buttonX = document.createElement("button");
    buttonX.setAttribute('onclick', 'onRemoveChosenLecturerClick("' + lecId + '", this)');
    buttonX.innerHTML = "X";

    var inputLecId = document.createElement("input");
    inputLecId.className = "chosen_lecturer";
    inputLecId.type = "hidden";
    inputLecId.value = lecId;
    inputLecId.name = "chosen_lecturer";

    pContainer.appendChild(imgAvatar);
    pContainer.appendChild(spanName);
    pContainer.appendChild(buttonX);
    pContainer.appendChild(inputLecId);

    // Add pContainer to Html page
    var chosenLecturerContainer = document.getElementById("chosen_lecturer_container");
    chosenLecturerContainer.appendChild(pContainer);
}

function onRemoveChosenLecturerClick(removedLecturerID, button) {
    var grandPa = button.parentNode.parentNode
    grandPa.removeChild(button.parentNode);

    var lecturerInforElementList = document.getElementsByClassName("lecturer_infor");

    for (var lecInfor of lecturerInforElementList) {
        if (lecInfor.value == removedLecturerID) {
            lecInfor.parentNode.style.display = "";
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
    var chosenLecturerElements = document.getElementsByClassName("chosen_lecturer");

    for (var chosenLec of chosenLecturerElements) {
        htmlContent += chosenLec.outerHTML + "\n";
    }

    return htmlContent;
}

function createEventDetailParameter() {
    var htmlContent = "";

    var eventName = document.getElementById("input_event_name").value;
    var eventNameInput = '<input type="hidden" name="eventName" value="' + eventName + '" /> \n';

    var eventDescription = document.getElementById("input_event_description").value;
    var eventDescriptionInput = '<input type="hidden" name="description" value="' + eventDescription + '" /> \n';

    htmlContent += eventNameInput;
    htmlContent += eventDescriptionInput;

    return htmlContent;
}

function createActionParameter () {
    return '<input type="hidden" name="action" value="Review" />\n';
}