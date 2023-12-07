var Studentstyle = document.createElement('style');
var Advisorstyle = document.createElement('style');
Advisorstyle.textContent = ".advisor {display: none;}";
Studentstyle.textContent = ".student {display: flex;}";
document.head.append(Studentstyle);
document.head.append(Advisorstyle);

function ChangeView(radio) {
    var selectedValue = radio.value;
    console.log(selectedValue);
    if (selectedValue == "student") {
        var Studentstyle = document.createElement('style');
        Studentstyle.textContent = ".student {display: flex;}";
        var Advisorstyle = document.createElement('style');
        Advisorstyle.textContent = ".advisor {display: none;}";
        document.head.append(Studentstyle);
        document.head.append(Advisorstyle);
    } else {
        var Studentstyle = document.createElement('style');
        var Advisorstyle = document.createElement('style');
        Advisorstyle.textContent = ".advisor {display: flex;}";
        Studentstyle.textContent = ".student {display: none;}";
        document.head.append(Studentstyle);
        document.head.append(Advisorstyle);
    }
}



document.querySelectorAll('#radioButtons input[name="role"]').forEach(function (radio) {
    radio.addEventListener('change', () => ChangeView(radio));
});