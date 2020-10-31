$(document).on("click", '#addHoliday', function() {

    var input1 = document.getElementById('holidaydate').value;
    var holiday_date = input1.split("-");
    var new_date = new Date(holiday_date[2], holiday_date[1]-1 , holiday_date[0]);
    var holidayarray = [];
    if (document.getElementById('holidayhidden') != null) {
        var olddates = document.getElementById('holidayhidden').value.split(",");

        olddates.forEach(element => {
            holidayarray.push(element)
        });
    }
        holidayarray.push(new_date);
        holidayarray.sort();
        document.getElementById('holidaydate').value = "";
        document.getElementById('holidaydate').dataset.holiday = holidayarray;
        document.getElementById('holidayhidden').value = holidayarray;

        var holidaydiv = document.getElementById("holidayslist");
        holidaydiv.innerHTML = "";
        
        holidayarray.forEach(holidayfunction);
        
        function holidayfunction(value) {
            if (value != "") {
            holidaydiv.innerHTML += `<p>- ${value} </p>`;
            }
        }  

});