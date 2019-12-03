import { initSweetalert } from '../plugins/init_sweetalert';

const loadSweetAlert = () => {
  const sweet_alert = document.getElementById("edit-form-done");
  const username = "<%= current_user.username%>"

  var span = document.createElement("span");
  span.innerHTML='<p id="sw-intro">Use this link to invite responses to your survey:</p><a href="http://localhost:3000/${username}" class="sw-link">www.dcme.today/susanna</a>'

  if (sweet_alert) {
    sweet_alert.addEventListener('click', (event) => {
      event.preventDefault();

      swal({
        title: "Are you sure?",
        text: "Once completed, you will not be able to edit this survey further!",
        icon: "warning",
        buttons: ["Back to Editing", "I'm sure"],
        dangerMode: true,
      })
    .then((continueButton) => {
      if (continueButton) {
        swal({
          title: "Survey Created!",
          text: "Your survey is now ready to be shared with the world 🌍📝",
          content: span,
          icon: "success",
        });
        const final_button = document.querySelector(".swal-button--confirm")
        final_button.addEventListener('click', (event) => {
          const link = document.getElementById("redirect");
        link.click();
        });
      }
    });

    });
  };
};

export { loadSweetAlert };

