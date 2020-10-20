
function datepicker() {
    flatpickr('.flatpickrdate', {
        altFormat: "F j, Y",
        dateFormat: "d-m-Y",

    });
}



export { datepicker }