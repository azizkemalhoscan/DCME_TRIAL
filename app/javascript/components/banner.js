import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  if (document.querySelector("#banner-typed-text")) {
    new Typed('#banner-typed-text', {
      strings: ["Today!"],
      typeSpeed: 200,
      loop: true,
      showCursor: false
    });
  }
}

export { loadDynamicBannerText };
