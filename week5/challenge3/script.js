const link = document.querySelectorAll("nav a");

link.forEach(a =>{
    a.addEventListener("click", (event) =>{
        alert(" clicked!");
    });
});

// const link = document.querySelectorAll("nav a");

// for(let i = 0; i<link.length; i++){
//     link[i].addEventListener("click", (event) =>{
//         event.preventDefault();
//         alert(link[i].innerHTML + " clicked!");
//     });
// }