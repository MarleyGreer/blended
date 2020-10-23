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

    flatpickr('.flatpickrdate', {
        dateFormat: "d-m-Y",
        altFormat: "F j, Y", 
        onDayCreate: function(dObj, dStr, fp, dayElem) {
            var day = dayElem.dateObj.getUTCDate();
            var month = dayElem.dateObj.getUTCMonth();
            var year = dayElem.dateObj.getUTCFullYear();
            var date = `${day}-${month}-${year}`
            if (dates.includes(date)) {
                dayElem.style.background = 'red';
            }
        }
    });
}




export { datepicker }