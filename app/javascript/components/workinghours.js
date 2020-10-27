$(document).on("click", '.disable',function() {
    console.log(this.id);
    var input1 = document.getElementById('working_hour_' + this.id + 'start_time_4i');
    var input2 = document.getElementById('working_hour_' + this.id + 'start_time_5i');
    var input3 = document.getElementById('working_hour_' + this.id + 'end_time_4i');
    var input4 = document.getElementById('working_hour_' + this.id + 'end_time_5i');
    if (this.checked) {
        input1.disabled = true;
        input1.value = "";
        input2.disabled = true;
        input2.value = "";
        input3.disabled = true;
        input3.value = "";
        input4.disabled = true;
        input4.value = "";
    } else {
        input1.disabled = false;
        input2.disabled = false;
        input3.disabled = false;
        input4.disabled = false;

    }
});