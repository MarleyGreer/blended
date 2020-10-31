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
        var timesubmit = document.getElementById('timesubmit');
        if (timesubmit != null) {timesubmit.disabled = false};
    });
    $('#booking_start_time').on("change", function() {
        var timesubmit = document.getElementById('timesubmit');
        if (timesubmit != null) {timesubmit.disabled = false};
    });
};

function confirmbtn() {
    $('#confirmbtn').on("click", function() {
        document.getElementById('selecttime').style.display = 'none';
        document.getElementById('confirmdetails').style.display = 'block';
        document.getElementById('headerdetails').innerHTML = 'confirm booking';
        var a = document.getElementById('booking_start_time').value;
        var time = a.substring(a.indexOf("T")+1, a.indexOf("T")+6);
        document.getElementById('starttimedisplay').innerHTML = time;      
    });
};

export {addDuration}
export {enablebutton}
export {confirmbtn}