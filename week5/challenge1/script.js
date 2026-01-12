const main_id = document.getElementById("main");
const p = main_id.getElementsByTagName("p");

for(let i =0; i<p.length;i++){
    p[i].style.fontSize = "24px";
    p[i].style.color = "red";
}