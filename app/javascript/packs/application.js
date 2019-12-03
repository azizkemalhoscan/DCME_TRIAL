import "bootstrap";
import "chart.js/dist/Chart.min.js";
import "chart.js/dist/Chart.min.css";

// import "chartkick/dist/chartkick.min.js";
// import { loadDynamicBannerText } from '../components/banner';
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

import { loadDynamicBannerText } from '../components/banner';
loadDynamicBannerText();

import { loadSweetAlert } from '../components/sweet_alert';
loadSweetAlert();

