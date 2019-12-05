const button = document.querySelector(".learn-more");
const section = document.getElementById("features");

const scrollToSection= () => {
  if (section) {
  button.addEventListener("click", (event) => {
    event.preventDefault();
    console.log(button);
    section.scrollIntoView();
  });
}
};
export { scrollToSection };
