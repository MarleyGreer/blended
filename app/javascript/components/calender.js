function datepicker() {
    var startDate = new Date();
    var endDate = new Date();
    startDate.setDate(startDate.getDate() - 180);
    endDate.setDate(endDate.getDate() + 730);
    var getDates = function(startD, endD) {
        var dates = [],
        currentDate = startD,
        addDays = function(days) {
            var date = new Date(this.valueOf());
            date.setDate(date.getDate() + days);
            return date;
        };
        while (currentDate <= endDate) {
            var cday = currentDate.getUTCDate();
            var cmonth = currentDate.getUTCMonth();
            var cyear = currentDate.getUTCFullYear();
            dates.push(`${cday}-${cmonth}-${cyear}`);
            currentDate = addDays.call(currentDate, 1);
        }
        return dates;
    };
    // Usage
    var dates = getDates(startDate, endDate);
    var workinghours = document.getElementById('working_hours');
    if (workinghours != null) {
        var workinghours = JSON.parse(workinghours.dataset.workingHours);
        console.log(workinghours);
        var unavailable_days = [];
        if (workinghours.mondaystart_time === null) { unavailable_days.push(1) };
        if (workinghours.tuesdaystart_time === null) { unavailable_days.push(2) };
        if (workinghours.wednesdaystart_time === null) { unavailable_days.push(3) };
        if (workinghours.thursdaystart_time === null) { unavailable_days.push(4) };
        if (workinghours.fridaystart_time === null) { unavailable_days.push(5) };
        if (workinghours.saturdaystart_time === null) { unavailable_days.push(6) };
        if (workinghours.sundaystart_time === null) { unavailable_days.push(0) };
        console.log(unavailable_days);
    }

    flatpickr('.flatpickrdate', {
        dateFormat: "d-m-Y",
        altFormat: "F j, Y", 
        disableMobile: "true",
        disable: [
            function(date) {
                return unavailable_days.includes(date.getDay());
            }
        ],
        // onDayCreate: function(dObj, dStr, fp, dayElem) {
        //     var day = dayElem.dateObj.getDay();
        //     console.log(day)
        //     if (unavailable_days.includes(day)) {
        //         dayElem.classList.add('unavailabledate');
        //     }
        //     dayElem.disable;
        // }
    });
}




export { datepicker }