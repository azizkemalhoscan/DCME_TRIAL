const button = document.querySelector(".learn-more");
const section = document.getElementById("features");

const scrollToSection= () => {
  button.addEventListener("click", (event) => {
    section.scrollIntoView();
  });
}

export { scrollToSection };
