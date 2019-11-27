import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  if (document.querySelector("#banner-typed-text")) {
    new Typed('#banner-typed-text', {
      strings: ["today!"],
      typeSpeed: 100,
      loop: true,
      showCursor: false
    });
  }
}

export { loadDynamicBannerText };
