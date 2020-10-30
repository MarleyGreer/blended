function togglesearch() {
    const searchbutton = document.getElementById('searchbutton');
    if (searchbutton) {
    searchbutton.addEventListener("click", (event) => {
        var searchbar = document.querySelector('#searchbar').style.display;
        if (searchbar == "none") {
            console.log("none");
            document.querySelector('#searchbar').style.display = "block"} else {
                console.log("block")
                document.querySelector('#searchbar').style.display = "none"
            }
    });
  }
};


$(document).on("click", '#byLocation', function() {
    var locationbutton = document.getElementById('locationFilter');
    var namebutton = document.getElementById('nameFilter');
    locationbutton.style.display = "block";
    namebutton.style.display = "none";
});

$(document).on("click", '#byName', function() {
    var locationbutton = document.getElementById('locationFilter');
    var namebutton = document.getElementById('nameFilter');
    locationbutton.style.display = "none";
    namebutton.style.display = "block";
});


export {togglesearch};
