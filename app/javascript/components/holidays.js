$(document).on("click", '#addHoliday', function() {

    var input1 = document.getElementById('holidaydate').value;
    var holiday_date = input1.split("-");
    var new_date = new Date(holiday_date[2], holiday_date[1]-1 , holiday_date[0]);
    var holidayarray = [];
    var olddates = document.getElementById('holidayhidden').value.split(",");
    console.log(olddates);
    console.log(new_date);
    olddates.forEach(element => {
        holidayarray.push(element)
    });
    holidayarray.push(new_date);
    console.log(input1);
    console.log(holiday_date);
    console.log(holidayarray);
    document.getElementById('holidaydate').value = "";
    document.getElementById('holidaydate').dataset.holiday = holidayarray;
    document.getElementById('holidayhidden').value = holidayarray;
});