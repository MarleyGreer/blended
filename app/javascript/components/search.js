function togglesearch() {
    const searchbutton = document.getElementById('searchbutton');
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

export {togglesearch}
