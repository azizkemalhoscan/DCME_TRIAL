import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  console.log('test');
  if (document.querySelector("#banner-typed-text")) {
    console.log('test2');
    new Typed('#banner-typed-text', {
      strings: ["today!"],
      typeSpeed: 300,
      loop: false,
      showCursor: false
    });
  }
}

export { loadDynamicBannerText };
