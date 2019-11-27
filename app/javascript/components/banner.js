import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["today!"],
    typeSpeed: 100,
    loop: true,
    showCursor: false
  });
}

export { loadDynamicBannerText };
