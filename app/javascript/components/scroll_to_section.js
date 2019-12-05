const button = document.querySelector(".learn-more");
const section = document.getElementById("features");

const scrollToSection= () => {
  button.addEventListener("click", (event) => {
    event.preventDefault();
    section.scrollIntoView();
  });
}

export { scrollToSection };
