document.addEventListener("DOMContentLoaded", function () {

    // display error message

    let errorMsg = document.querySelector(".errorMsg");
    if (errorMsg.innerText !== '') {
        errorMsg.classList.remove("d-none");
    }

});


