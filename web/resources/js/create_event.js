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
    var input, filter, lecturer_list, a, txtValue;
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase().trim();

    lecturer_list = document.getElementById("lecturer_list");
    li_list = lecturer_list.getElementsByTagName("li");
    for (var lecItem of li_list) {
        a = lecItem.getElementsByClassName("lec_name")[0];
        txtValue = a.textContent || a.innerText;
        if (txtValue.toUpperCase().trim().includes(filter)) {
            lecItem.style.display = "block";
        } else {
            lecItem.style.display = "none";
        }
    }
}


// CHOOSE LECTURER 
function onChooseLecturer(button) {
    // Hide itself
    button.style.display = "none";

    // Extract Lecturer Data
    var lecId = button.getElementsByTagName("input")[0].value;
    var lecAvatar = button.getElementsByClassName("lec-avatar")[0].src;
    var lecName = button.getElementsByClassName("lec_name")[0].innerHTML;

    // Button Model
//     <div class="chosen_lecturer_item col-12 col-lg-7">
    //     <div class="d-flex align-items-center">
    //         <img class="rounded-circle lec-avatar " src="${chosenLec.avatar}"> 
    //         <p class="chosen_lec_name">${chosenLec.name}</p>
    //     </div>
    //     <input class="chosen_lecturer d-none" type="hidden" name="chosen_lecturer" value="1"/>
    //     <img class="btn_remove_lec" onclick="onRemoveChosenLecturerClick('${chosenLec.id}', this)" src="resources/icon/icon_remove_lecturer.svg"/>
//     </div>

    // Create Chosen Lecturer ELement
    var divChosenLecItem = document.createElement("div");
    divChosenLecItem.className = "chosen_lecturer_item col-12 col-lg-7";

    var divAvarName = document.createElement("div");
    divAvarName.className = "d-flex align-items-center";

    var imgLecAvar = document.createElement("img");
    imgLecAvar.className = "rounded-circle lec-avatar";
    imgLecAvar.src = lecAvatar;

    var pLecName = document.createElement("p");
    pLecName.className = "chosen_lec_name ";
    pLecName.innerHTML = lecName;

    divAvarName.appendChild(imgLecAvar);
    divAvarName.appendChild(pLecName);

    var inputLecIdValue = document.createElement("input");
    inputLecIdValue.className = "chosen_lecturer d-none";
    inputLecIdValue.type = "hidden";
    inputLecIdValue.name= "chosen_lecturer";
    inputLecIdValue.value= lecId;

    var btnRemoveLec =  document.createElement("img");
    btnRemoveLec.className = "btn_remove_lec";
    btnRemoveLec.setAttribute("onclick", 'onRemoveChosenLecturerClick("'+ lecId +'", this)'); 
    btnRemoveLec.src="resources/icon/icon_remove_lecturer.svg"

    divChosenLecItem.appendChild(divAvarName);
    divChosenLecItem.appendChild(inputLecIdValue);
    divChosenLecItem.appendChild(btnRemoveLec);

    // Add pContainer to Html page
    var chosenLecturerContainer = document.getElementById("chosen_lecturer_container");
    chosenLecturerContainer.appendChild(divChosenLecItem);
}

function onRemoveChosenLecturerClick(removedLecturerID, button) {
    var grandPa = button.parentNode.parentNode
    grandPa.removeChild(button.parentNode);

    var lecturerInforElementList = document.getElementsByClassName("lecturer_infor");

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

    var eventDescriptionTest = CKEDITOR.instances.input_event_description.getData();
    var eventDescriptionInput = '<textarea style="display:none;" name="description">'+ eventDescriptionTest + '</textarea>';

    htmlContent += eventNameInput;
    htmlContent += eventDescriptionInput;

    return htmlContent;
}

function createActionParameter () {
    return '<input type="hidden" name="action" value="Review" />\n';
}
