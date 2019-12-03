import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  console.log('test');
  if (document.querySelector("#banner-typed-text")) {
    console.log('test2');
    new Typed('#banner-typed-text', {
      strings: ["Today!"],
      typeSpeed: 200,
      loop: true,
      showCursor: false
    });
  }
}

export { loadDynamicBannerText };
