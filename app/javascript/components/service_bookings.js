function addDuration() {

    $('input[type=number]').on("change", function() {

        var quantity = document.getElementsByClassName('quantity input');
        var calc_total = 0;
        Array.from(quantity).forEach ((quantity) => {
            console.log(parseInt(quantity.value));
            console.log(parseInt(quantity.dataset.duration));
            if (parseInt(quantity.value)) calc_total = calc_total + parseInt(quantity.value) * parseInt(quantity.dataset.duration) ;
            console.log(calc_total);
        });
        $("#duration").html(`${calc_total} minutes`);
        console.log(document.getElementById('servicesubmit'));
        document.getElementById('servicesubmit').disabled = false;
        console.log(document.getElementById('servicesubmit'));
    }); 
};

function enablebutton() {
    $('.flatpickrdate').on("change", function() {
        document.getElementById('timesubmit').disabled = false;
    });
    $('#booking_start_time').on("change", function() {
        document.getElementById('timesubmit').disabled = false;
    });
};

export {addDuration}
export {enablebutton}