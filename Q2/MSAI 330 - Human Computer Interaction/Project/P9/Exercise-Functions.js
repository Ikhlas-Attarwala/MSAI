// GLOBAL VARIABLES:

DistList = ["mi", "km", "min", "hr"]
LiftList = ["lbs", "kg", "min", "hr"]
TimeList = ["min", "hr"]
Days1_28 = [
    "1", "2", "3", "4", "5",
    "6", "7", "8", "9", "10",
    "11", "12", "13", "14", "15",
    "16", "17", "18", "19", "20",
    "21", "22", "23", "24", "25",
    "26", "27", "28"]
Days1_30 = [
    "1", "2", "3", "4", "5",
    "6", "7", "8", "9", "10",
    "11", "12", "13", "14", "15",
    "16", "17", "18", "19", "20",
    "21", "22", "23", "24", "25",
    "26", "27", "28", "29", "30"]
Days1_31 = [
    "1", "2", "3", "4", "5",
    "6", "7", "8", "9", "10",
    "11", "12", "13", "14", "15",
    "16", "17", "18", "19", "20",
    "21", "22", "23", "24", "25",
    "26", "27", "28", "29", "30", "31"]
Days28_ = ["29", "30", "31"]
Days30_ = ["31"]
var dropdowns = document.getElementsByClassName("dropdown-content");
var friends = ['dhingra', 'hammond',  'ottino']

// SHOW/HIDE GOAL TYPES LIST
function butt_drop_type() {
    // show/hide list
    document.getElementById("goals_type2").classList.toggle("show");
    // reset Enter Metric if empty
    if (document.getElementById("goals_metric").placeholder == "") {
        document.getElementById("goals_metric").placeholder = "Enter Metric";
    }
    // close all else
    for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show') && openDropdown.id != "goals_type2") {
            openDropdown.classList.remove('show');
        }
    }
}

// GOAL TYPES
function goaltype_pick(id) {
    // show/hide list
    document.getElementById("goals_type2").classList.toggle("show");
    // change name
    document.getElementById("goals_type").innerHTML =
        document.getElementById(id).innerHTML;
    // not yet
    // document.getElementById("goals_metric").placeholder = "Enter: Metric";
    // reset units
    document.getElementById("goals_unit").innerHTML = "Units";
}

// Enter Metric
function empty_field(id) {
    // hide placeholder
    document.getElementById(id).placeholder = "";
    // close all else
    for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show') && openDropdown.id != "goals_metric") {
            openDropdown.classList.remove('show');
        }
    }
}

// CHECK IF SET IS MATCHED AS TYPING
// this covers Metric
function checkFin() {
    // SET!! Note: Each of these variables change as the form is filled out, so
    // the variables need to be 're-captured' here, and thus re-stated each time
    var metricSet = document.getElementById("goals_metric").value != "";
    var unitsSet = document.getElementById("goals_unit").innerHTML != "Units";
    var ddSet = document.getElementById("goals_dueD").innerHTML != "DD";
    var yySet = document.getElementById("goals_dueY").innerHTML != "YYYY";
    if (unitsSet && ddSet && yySet) {
        if (document.getElementById("goalvscomp").innerHTML == "Set Goal!") {
            document.getElementById("id_setGoal").style.opacity = 1;
            document.getElementById("id_setGoal").href = "Goals.html";
        }
        if (document.getElementById("goalvscomp").innerHTML == "Compete!") {
            document.getElementById("id_setComp").style.opacity = 1;
            document.getElementById("id_setComp").href = "Competitions.html";
        }
    }
}

// CHECK IF SET IS MATCHED AS TYPING
// this covers Metric
function checkFin2() {
    // SET!! Note: Each of these variables change as the form is filled out, so
    // the variables need to be 're-captured' here, and thus re-stated each time
    var metricSet = document.getElementById("goals_metric").value != "";
    var unitsSet = document.getElementById("goals_unit").innerHTML != "Units";
    var ddSet = document.getElementById("goals_dueD").innerHTML != "DD";
    var yySet = document.getElementById("goals_dueY").innerHTML != "YYYY";
    var friendSet = document.getElementById("inv_friends").innerHTML.includes('Search');
    friendSet = !friendSet;
    if (unitsSet && ddSet && yySet && friendSet) {
        if (document.getElementById("goalvscomp").innerHTML == "Set Goal!") {
            document.getElementById("id_setGoal").style.opacity = 1;
            document.getElementById("id_setGoal").href = "Goals.html";
        }
        if (document.getElementById("goalvscomp").innerHTML == "Compete!") {
            document.getElementById("id_setComp").style.opacity = 1;
            document.getElementById("id_setComp").href = "Competitions.html";
        }
    }
}

// GOAL UNITS FIRST CLICK
function butt_drop_units(id) {
    // show/hide list
    document.getElementById(id + String(2)).classList.toggle("show");
    // reset Enter Metric if empty
    if (document.getElementById("goals_metric").placeholder == "") {
        document.getElementById("goals_metric").placeholder = "Enter Metric";
    }
    // close all else
    for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show') && openDropdown.id != "goals_unit2") {
            openDropdown.classList.remove('show');
        }
    }
    // comments inside 'Cycling'
    if (document.getElementById("goals_type").innerHTML == "Cycling") {
        // change color of other units
        document.getElementById("lbs").style.color = 'rgb(175, 175, 175)';
        document.getElementById("kg").style.color = 'rgb(175, 175, 175)';
        document.getElementById("mi").style.color = 'rgb(0, 0, 0)';
        document.getElementById("km").style.color = 'rgb(0, 0, 0)';
        document.getElementById("min").style.color = 'rgb(0, 0, 0)';
        document.getElementById("hr").style.color = 'rgb(0, 0, 0)';
    }
    if (document.getElementById("goals_type").innerHTML == "Running") {
        document.getElementById("lbs").style.color = 'rgb(175, 175, 175)';
        document.getElementById("kg").style.color = 'rgb(175, 175, 175)';
        document.getElementById("mi").style.color = 'rgb(0, 0, 0)';
        document.getElementById("km").style.color = 'rgb(0, 0, 0)';
        document.getElementById("min").style.color = 'rgb(0, 0, 0)';
        document.getElementById("hr").style.color = 'rgb(0, 0, 0)';
    }
    if (document.getElementById("goals_type").innerHTML == "Weight Lifting") {
        document.getElementById("lbs").style.color = 'rgb(0, 0, 0)';
        document.getElementById("kg").style.color = 'rgb(0, 0, 0)';
        document.getElementById("mi").style.color = 'rgb(175, 175, 175)';
        document.getElementById("km").style.color = 'rgb(175, 175, 175)';
        document.getElementById("min").style.color = 'rgb(0, 0, 0)';
        document.getElementById("hr").style.color = 'rgb(0, 0, 0)';
    }
    if (document.getElementById("goals_type").innerHTML == "Swimming") {
        document.getElementById("lbs").style.color = 'rgb(175, 175, 175)';
        document.getElementById("kg").style.color = 'rgb(175, 175, 175)';
        document.getElementById("mi").style.color = 'rgb(0, 0, 0)';
        document.getElementById("km").style.color = 'rgb(0, 0, 0)';
        document.getElementById("min").style.color = 'rgb(0, 0, 0)';
        document.getElementById("hr").style.color = 'rgb(0, 0, 0)';
    }
    if (document.getElementById("goals_type").innerHTML == "Frequency") {
        document.getElementById("lbs").style.color = 'rgb(175, 175, 175)';
        document.getElementById("kg").style.color = 'rgb(175, 175, 175)';
        document.getElementById("mi").style.color = 'rgb(175, 175, 175)';
        document.getElementById("km").style.color = 'rgb(175, 175, 175)';
        document.getElementById("min").style.color = 'rgb(0, 0, 0)';
        document.getElementById("hr").style.color = 'rgb(0, 0, 0)';
    }
    if (document.getElementById("goals_type").innerHTML == "Goal Type") {
        document.getElementById("lbs").style.color = 'rgb(175, 175, 175)';
        document.getElementById("kg").style.color = 'rgb(175, 175, 175)';
        document.getElementById("mi").style.color = 'rgb(175, 175, 175)';
        document.getElementById("km").style.color = 'rgb(175, 175, 175)';
        document.getElementById("min").style.color = 'rgb(175, 175, 175)';
        document.getElementById("hr").style.color = 'rgb(175, 175, 175)';
    }
    if (document.getElementById("goals_type").innerHTML == "Competition Type") {
        document.getElementById("lbs").style.color = 'rgb(175, 175, 175)';
        document.getElementById("kg").style.color = 'rgb(175, 175, 175)';
        document.getElementById("mi").style.color = 'rgb(175, 175, 175)';
        document.getElementById("km").style.color = 'rgb(175, 175, 175)';
        document.getElementById("min").style.color = 'rgb(175, 175, 175)';
        document.getElementById("hr").style.color = 'rgb(175, 175, 175)';
    }
}

// GOAL UNITS THEMSELVES
function goalunit_pick(id) {
    // comments inside
    if (document.getElementById("goals_type").innerHTML == "Cycling"
        && DistList.indexOf(id) >= 0) {
        // change name to id
        document.getElementById("goals_unit").innerHTML =
            document.getElementById(id).innerHTML;
        // hide list
        document.getElementById("goals_unit2").classList.toggle("show");
    }
    if (document.getElementById("goals_type").innerHTML == "Running"
        && DistList.indexOf(id) >= 0) {
        document.getElementById("goals_unit").innerHTML =
            document.getElementById(id).innerHTML;
        document.getElementById("goals_unit2").classList.toggle("show");
    }
    if (document.getElementById("goals_type").innerHTML == "Weight Lifting"
        && LiftList.indexOf(id) >= 0) {
        document.getElementById("goals_unit").innerHTML =
            document.getElementById(id).innerHTML;
        document.getElementById("goals_unit2").classList.toggle("show");
    }
    if (document.getElementById("goals_type").innerHTML == "Swimming"
        && DistList.indexOf(id) >= 0) {
        document.getElementById("goals_unit").innerHTML =
            document.getElementById(id).innerHTML;
        document.getElementById("goals_unit2").classList.toggle("show");
    }
    if (document.getElementById("goals_type").innerHTML == "Frequency"
        && TimeList.indexOf(id) >= 0) {
        document.getElementById("goals_unit").innerHTML =
            document.getElementById(id).innerHTML;
        document.getElementById("goals_unit2").classList.toggle("show");
    }
    // SET!! Note: Each of these variables change as the form is filled out, so
    // the variables need to be 're-captured' here, and thus re-stated each time
    var metricSet = document.getElementById("goals_metric").value != "";
    var unitsSet = document.getElementById("goals_unit").innerHTML != "Units";
    var ddSet = document.getElementById("goals_dueD").innerHTML != "DD";
    var yySet = document.getElementById("goals_dueY").innerHTML != "YYYY";
    if (metricSet && ddSet && yySet) {
        if (document.getElementById("goalvscomp").innerHTML == "Set Goal!") {
            document.getElementById("id_setGoal").style.opacity = 1;
            document.getElementById("id_setGoal").href = "Goals.html";
        }
        if (document.getElementById("goalvscomp").innerHTML == "Compete!") {
            document.getElementById("id_setComp").style.opacity = 1;
            document.getElementById("id_setComp").href = "Competitions.html";
        }
    }
}

function goalunit_pick2(id) {
    // comments inside
    if (document.getElementById("goals_type").innerHTML == "Cycling"
        && DistList.indexOf(id) >= 0) {
        // change name to id
        document.getElementById("goals_unit").innerHTML =
            document.getElementById(id).innerHTML;
        // hide list
        document.getElementById("goals_unit2").classList.toggle("show");
    }
    if (document.getElementById("goals_type").innerHTML == "Running"
        && DistList.indexOf(id) >= 0) {
        document.getElementById("goals_unit").innerHTML =
            document.getElementById(id).innerHTML;
        document.getElementById("goals_unit2").classList.toggle("show");
    }
    if (document.getElementById("goals_type").innerHTML == "Weight Lifting"
        && LiftList.indexOf(id) >= 0) {
        document.getElementById("goals_unit").innerHTML =
            document.getElementById(id).innerHTML;
        document.getElementById("goals_unit2").classList.toggle("show");
    }
    if (document.getElementById("goals_type").innerHTML == "Swimming"
        && DistList.indexOf(id) >= 0) {
        document.getElementById("goals_unit").innerHTML =
            document.getElementById(id).innerHTML;
        document.getElementById("goals_unit2").classList.toggle("show");
    }
    if (document.getElementById("goals_type").innerHTML == "Frequency"
        && TimeList.indexOf(id) >= 0) {
        document.getElementById("goals_unit").innerHTML =
            document.getElementById(id).innerHTML;
        document.getElementById("goals_unit2").classList.toggle("show");
    }
    // SET!! Note: Each of these variables change as the form is filled out, so
    // the variables need to be 're-captured' here, and thus re-stated each time
    var metricSet = document.getElementById("goals_metric").value != "";
    var unitsSet = document.getElementById("goals_unit").innerHTML != "Units";
    var ddSet = document.getElementById("goals_dueD").innerHTML != "DD";
    var yySet = document.getElementById("goals_dueY").innerHTML != "YYYY";
    var friendSet = document.getElementById("inv_friends").innerHTML.includes('Search');
    friendSet = !friendSet;
    if (metricSet && ddSet && yySet && friendSet) {
        if (document.getElementById("goalvscomp").innerHTML == "Set Goal!") {
            document.getElementById("id_setGoal").style.opacity = 1;
            document.getElementById("id_setGoal").href = "Goals.html";
        }
        if (document.getElementById("goalvscomp").innerHTML == "Compete!") {
            document.getElementById("id_setComp").style.opacity = 1;
            document.getElementById("id_setComp").href = "Competitions.html";
        }
    }
}

// MONTH
function butt_dateM(id) {
    // show/hide list
    document.getElementById(id + String(2)).classList.toggle("show");
    // reset Enter Metric if empty
    if (document.getElementById("goals_metric").placeholder == "") {
        document.getElementById("goals_metric").placeholder = "Enter Metric";
    }
    // close all else
    for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show') && openDropdown.id != "goals_dueM2") {
            openDropdown.classList.remove('show');
        }
    }
}
function dateM_pick(id) {
    // change name to id
    document.getElementById("goals_dueM").innerHTML =
        document.getElementById(id).innerHTML;
    document.getElementById("goals_dueM2").classList.toggle("show");
    document.getElementById("goals_dueD").innerHTML = "DD";
}

// DATE
function butt_dateD(id) {
    // show/hide list
    document.getElementById(id + String(2)).classList.toggle("show");
    // reset Enter Metric if empty
    if (document.getElementById("goals_metric").placeholder == "") {
        document.getElementById("goals_metric").placeholder = "Enter Metric";
    }
    // close all else
    for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show') && openDropdown.id != "goals_dueD2") {
            openDropdown.classList.remove('show');
        }
    }
    // gray out by month
    if (document.getElementById("goals_dueM").innerHTML == "Jan") {
        for (i = 0; i < Days1_31.length; i++) {
            document.getElementById("d" + String(Days1_31[i])).style.color = 'rgb(0, 0, 0)';
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Feb") {
        for (i = 0; i < Days28_.length; i++) {
            document.getElementById("d" + String(Days28_[i])).style.color = 'rgb(175, 175, 175)';
        }
        for (i = 0; i < Days1_28.length + 1; i++) {
            document.getElementById("d" + String(Days1_28[i])).style.color = 'rgb(0, 0, 0)';
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Mar") {
        for (i = 0; i < Days1_31.length; i++) {
            document.getElementById("d" + String(Days1_31[i])).style.color = 'rgb(0, 0, 0)';
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Apr") {
        for (i = 0; i < Days30_.length; i++) {
            document.getElementById("d" + String(Days30_[i])).style.color = 'rgb(175, 175, 175)';
        }
        for (i = 0; i < Days1_30.length + 1; i++) {
            document.getElementById("d" + String(Days1_30[i])).style.color = 'rgb(0, 0, 0)';
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "May") {
        for (i = 0; i < Days1_31.length; i++) {
            document.getElementById("d" + String(Days1_31[i])).style.color = 'rgb(0, 0, 0)';
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Jun") {
        for (i = 0; i < Days30_.length; i++) {
            document.getElementById("d" + String(Days30_[i])).style.color = 'rgb(175, 175, 175)';
        }
        for (i = 0; i < Days1_30.length + 1; i++) {
            document.getElementById("d" + String(Days1_30[i])).style.color = 'rgb(0, 0, 0)';
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Jul") {
        for (i = 0; i < Days1_31.length; i++) {
            document.getElementById("d" + String(Days1_31[i])).style.color = 'rgb(0, 0, 0)';
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Aug") {
        for (i = 0; i < Days1_31.length; i++) {
            document.getElementById("d" + String(Days1_31[i])).style.color = 'rgb(0, 0, 0)';
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Sep") {
        for (i = 0; i < Days30_.length; i++) {
            document.getElementById("d" + String(Days30_[i])).style.color = 'rgb(175, 175, 175)';
        }
        for (i = 0; i < Days1_30.length + 1; i++) {
            document.getElementById("d" + String(Days1_30[i])).style.color = 'rgb(0, 0, 0)';
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Oct") {
        for (i = 0; i < Days1_31.length; i++) {
            document.getElementById("d" + String(Days1_31[i])).style.color = 'rgb(0, 0, 0)';
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Nov") {
        for (i = 0; i < Days30_.length; i++) {
            document.getElementById("d" + String(Days30_[i])).style.color = 'rgb(175, 175, 175)';
        }
        for (i = 0; i < Days1_30.length + 1; i++) {
            document.getElementById("d" + String(Days1_30[i])).style.color = 'rgb(0, 0, 0)';
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Dec") {
        for (i = 0; i < Days1_31.length; i++) {
            document.getElementById("d" + String(Days1_31[i])).style.color = 'rgb(0, 0, 0)';
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "MM") {
        for (i = 1; i <= 31; i++) {
            document.getElementById("d" + String(i)).style.color = 'rgb(175, 175, 175)';
        }
    }
}

function dateD_pick(id) {
    // comments inside Jan
    if (document.getElementById("goals_dueM").innerHTML == "Jan") {
        // change appropriate # to innerHTML
        document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
        // hide list
        document.getElementById("goals_dueD2").classList.toggle("show");
    }
    if (document.getElementById("goals_dueM").innerHTML == "Feb") {
        if (Days1_28.indexOf(id.substring(1)) >= 0) {
            document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
            document.getElementById("goals_dueD2").classList.toggle("show");
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Mar") {
        document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
        document.getElementById("goals_dueD2").classList.toggle("show");
    }
    if (document.getElementById("goals_dueM").innerHTML == "Apr") {
        if (id != "d31") {
            document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
            document.getElementById("goals_dueD2").classList.toggle("show");
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "May") {
        document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
        document.getElementById("goals_dueD2").classList.toggle("show");
    }
    if (document.getElementById("goals_dueM").innerHTML == "Jun") {
        if (id != "d31") {
            document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
            document.getElementById("goals_dueD2").classList.toggle("show");
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Jul") {
        document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
        document.getElementById("goals_dueD2").classList.toggle("show");
    }
    if (document.getElementById("goals_dueM").innerHTML == "Aug") {
        document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
        document.getElementById("goals_dueD2").classList.toggle("show");
    }
    if (document.getElementById("goals_dueM").innerHTML == "Sep") {
        if (id != "d31") {
            document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
            document.getElementById("goals_dueD2").classList.toggle("show");
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Oct") {
        document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
        document.getElementById("goals_dueD2").classList.toggle("show");
    }
    if (document.getElementById("goals_dueM").innerHTML == "Nov") {
        if (id != "d31") {
            document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
            document.getElementById("goals_dueD2").classList.toggle("show");
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Dec") {
        document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
        document.getElementById("goals_dueD2").classList.toggle("show");
    }
    // SET!! Note: Each of these variables change as the form is filled out, so
    // the variables need to be 're-captured' here, and thus re-stated each time
    var metricSet = document.getElementById("goals_metric").value != "";
    var unitsSet = document.getElementById("goals_unit").innerHTML != "Units";
    var ddSet = document.getElementById("goals_dueD").innerHTML != "DD";
    var yySet = document.getElementById("goals_dueY").innerHTML != "YYYY";
    if (metricSet && unitsSet && yySet) {
        if (document.getElementById("goalvscomp").innerHTML == "Set Goal!") {
            document.getElementById("id_setGoal").style.opacity = 1;
            document.getElementById("id_setGoal").href = "Goals.html";
        }
        if (document.getElementById("goalvscomp").innerHTML == "Compete!") {
            document.getElementById("id_setComp").style.opacity = 1;
            document.getElementById("id_setComp").href = "Competitions.html";
        }
    }
}

function dateD_pick2(id) {
    // comments inside Jan
    if (document.getElementById("goals_dueM").innerHTML == "Jan") {
        // change appropriate # to innerHTML
        document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
        // hide list
        document.getElementById("goals_dueD2").classList.toggle("show");
    }
    if (document.getElementById("goals_dueM").innerHTML == "Feb") {
        if (Days1_28.indexOf(id.substring(1)) >= 0) {
            document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
            document.getElementById("goals_dueD2").classList.toggle("show");
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Mar") {
        document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
        document.getElementById("goals_dueD2").classList.toggle("show");
    }
    if (document.getElementById("goals_dueM").innerHTML == "Apr") {
        if (id != "d31") {
            document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
            document.getElementById("goals_dueD2").classList.toggle("show");
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "May") {
        document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
        document.getElementById("goals_dueD2").classList.toggle("show");
    }
    if (document.getElementById("goals_dueM").innerHTML == "Jun") {
        if (id != "d31") {
            document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
            document.getElementById("goals_dueD2").classList.toggle("show");
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Jul") {
        document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
        document.getElementById("goals_dueD2").classList.toggle("show");
    }
    if (document.getElementById("goals_dueM").innerHTML == "Aug") {
        document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
        document.getElementById("goals_dueD2").classList.toggle("show");
    }
    if (document.getElementById("goals_dueM").innerHTML == "Sep") {
        if (id != "d31") {
            document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
            document.getElementById("goals_dueD2").classList.toggle("show");
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Oct") {
        document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
        document.getElementById("goals_dueD2").classList.toggle("show");
    }
    if (document.getElementById("goals_dueM").innerHTML == "Nov") {
        if (id != "d31") {
            document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
            document.getElementById("goals_dueD2").classList.toggle("show");
        }
    }
    if (document.getElementById("goals_dueM").innerHTML == "Dec") {
        document.getElementById("goals_dueD").innerHTML = document.getElementById(id).innerHTML;
        document.getElementById("goals_dueD2").classList.toggle("show");
    }
    // SET!! Note: Each of these variables change as the form is filled out, so
    // the variables need to be 're-captured' here, and thus re-stated each time
    var metricSet = document.getElementById("goals_metric").value != "";
    var unitsSet = document.getElementById("goals_unit").innerHTML != "Units";
    var ddSet = document.getElementById("goals_dueD").innerHTML != "DD";
    var yySet = document.getElementById("goals_dueY").innerHTML != "YYYY";
    var friendSet = document.getElementById("inv_friends").innerHTML.includes('Search');
    friendSet = !friendSet;
    if (metricSet && unitsSet && yySet && friendSet) {
        if (document.getElementById("goalvscomp").innerHTML == "Set Goal!") {
            document.getElementById("id_setGoal").style.opacity = 1;
            document.getElementById("id_setGoal").href = "Goals.html";
        }
        if (document.getElementById("goalvscomp").innerHTML == "Compete!") {
            document.getElementById("id_setComp").style.opacity = 1;
            document.getElementById("id_setComp").href = "Competitions.html";
        }
    }
}

// YEAR
function butt_dateY(id) {
    // show/hide list
    document.getElementById(id + String(2)).classList.toggle("show");
    // reset Enter Metric if empty
    if (document.getElementById("goals_metric").placeholder == "") {
        document.getElementById("goals_metric").placeholder = "Enter Metric";
    }
    // close all else
    for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show') && openDropdown.id != "goals_dueY2") {
            openDropdown.classList.remove('show');
        }
    }
}
function dateY_pick(id) {
    // change name to id
    document.getElementById("goals_dueY").innerHTML =
        document.getElementById(id).innerHTML;
    document.getElementById("goals_dueY2").classList.toggle("show");
    // SET!! Note: Each of these variables change as the form is filled out, so
    // the variables need to be 're-captured' here, and thus re-stated each time
    var metricSet = document.getElementById("goals_metric").value != "";
    var unitsSet = document.getElementById("goals_unit").innerHTML != "Units";
    var ddSet = document.getElementById("goals_dueD").innerHTML != "DD";
    var yySet = document.getElementById("goals_dueY").innerHTML != "YYYY";
    if (metricSet && unitsSet && ddSet) {
        if (document.getElementById("goalvscomp").innerHTML == "Set Goal!") {
            document.getElementById("id_setGoal").style.opacity = 1;
            document.getElementById("id_setGoal").href = "Goals.html";
        }
        if (document.getElementById("goalvscomp").innerHTML == "Compete!") {
            document.getElementById("id_setComp").style.opacity = 1;
            document.getElementById("id_setComp").href = "Competitions.html";
        }
    }
}
function dateY_pick2(id) {
    // change name to id
    document.getElementById("goals_dueY").innerHTML =
        document.getElementById(id).innerHTML;
    document.getElementById("goals_dueY2").classList.toggle("show");
    // SET!! Note: Each of these variables change as the form is filled out, so
    // the variables need to be 're-captured' here, and thus re-stated each time
    var metricSet = document.getElementById("goals_metric").value != "";
    var unitsSet = document.getElementById("goals_unit").innerHTML != "Units";
    var ddSet = document.getElementById("goals_dueD").innerHTML != "DD";
    var yySet = document.getElementById("goals_dueY").innerHTML != "YYYY";
    var friendSet = document.getElementById("inv_friends").innerHTML.includes('Search');
    friendSet = !friendSet;
    if (metricSet && unitsSet && ddSet && friendSet) {
        if (document.getElementById("goalvscomp").innerHTML == "Set Goal!") {
            document.getElementById("id_setGoal").style.opacity = 1;
            document.getElementById("id_setGoal").href = "Goals.html";
        }
        if (document.getElementById("goalvscomp").innerHTML == "Compete!") {
            document.getElementById("id_setComp").style.opacity = 1;
            document.getElementById("id_setComp").href = "Competitions.html";
        }
    }
}

function setGoal() {
    // none
}

// JOIN COMP
function joinComp() {
    alert("This feature is not yet active!\nTry creating a competition instead! :)")
}

// FRIENDS SEARCH CLICK
function invFriends() {
    // show/hide list
    document.getElementById("inv_friends2").classList.toggle("show");
    // reset Enter Metric if empty
    if (document.getElementById("goals_metric").placeholder == "") {
        document.getElementById("goals_metric").placeholder = "Enter Metric";
    }
    // close all else
    for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show') && openDropdown.id != "inv_friends2") {
            openDropdown.classList.remove('show');
        }
    }
}

// FRIEND PICK
function friend_pick(id) {
    // show/hide list
    document.getElementById("inv_friends2").classList.toggle("show");
    // change name
    document.getElementById("inv_friends").innerHTML =
        document.getElementById(id).innerHTML;
    // SET!! Note: Each of these variables change as the form is filled out, so
    // the variables need to be 're-captured' here, and thus re-stated each time
    var metricSet = document.getElementById("goals_metric").value != "";
    var unitsSet = document.getElementById("goals_unit").innerHTML != "Units";
    var ddSet = document.getElementById("goals_dueD").innerHTML != "DD";
    var yySet = document.getElementById("goals_dueY").innerHTML != "YYYY";
    var friendSet = document.getElementById("inv_friends").innerHTML.includes('Search');
    friendSet = !friendSet;
    if (metricSet && unitsSet && ddSet && yySet) {
        if (document.getElementById("goalvscomp").innerHTML == "Set Goal!") {
            document.getElementById("id_setGoal").style.opacity = 1;
            document.getElementById("id_setGoal").href = "Goals.html";
        }
        if (document.getElementById("goalvscomp").innerHTML == "Compete!") {
            document.getElementById("id_setComp").style.opacity = 1;
            document.getElementById("id_setComp").href = "Competitions.html";
        }
    }
}