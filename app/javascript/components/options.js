const loadOptionSelection = () => {


const checkBoxes = document.querySelectorAll(".form-check");

  checkBoxes.forEach((box) => {
    box.addEventListener('click', (event) => {
      checkBoxes.forEach( box => box.classList.remove("selected-option") )
      event.currentTarget.classList.add("selected-option")
    })
  })
}

export { loadOptionSelection }
