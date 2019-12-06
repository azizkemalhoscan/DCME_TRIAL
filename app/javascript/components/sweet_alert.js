import { initSweetalert } from '../plugins/init_sweetalert';

const loadSweetAlert = () => {
  const sweet_alert = document.getElementById("edit-form-done");
  if (sweet_alert) {

    let username = document.querySelector(".sweet-alert-username").dataset.username

    var span = document.createElement("span");
    span.innerHTML=`<p id="sw-intro">Please go to your profile and choose the survey that you would like to share</p>`


    sweet_alert.addEventListener('click', (event) => {
      event.preventDefault();

      swal({
        title: "Are you sure?",
        text: "Once published, you will not be able to edit this survey further!",
        icon: "warning",
        buttons: {
              confirm: {
                text: "I'm sure",
                className: "final-btn-filled"
              },
              cancel: {
                text: "Back to Editing",
                className: "final-btn-outline"
              }
            },
      })
      .then((continueButton) => {
        if (continueButton) {
          swal({
            title: "Survey Created!",
            text: "Your survey has been created.",
            content: span,
            icon: "success",
            buttons: {
              confirm: {
                text: "OK",
                className: "final-btn-filled"
              }
            }
          });
          const final_button = document.querySelector(".swal-button--confirm")
          final_button.addEventListener('click', (event) => {

        // const link = document.getElementById("redirect");
        // link.click();
            const survey_completed = document.getElementById("change-attribute");
            survey_completed.click();
          });
        }
      });
    });
  };

  const sw_share_survey = document.getElementById("share-survey");
  if (sw_share_survey) {
    let username = document.querySelector(".sweet-alert-username").dataset.username

    var span = document.createElement("span");
    span.innerHTML=`<p id="sw-intro">Use this link to invite responses to your survey:</p><a href="/${username}" class="sw-link">www.dcme.today/${username}</a>`

    sw_share_survey.addEventListener('click', (event) => {
      event.preventDefault();
      swal({
          title: "Share your survey!",
          text: "Your survey can be shared with the world 🌍📝",
          content: span,
          icon: "success",
          buttons: {
            confirm: {
              text: "OK",
              className: "final-btn-filled"
            }
          }
        });


    });
  }
};


export { loadSweetAlert };

