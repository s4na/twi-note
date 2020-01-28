import Swiper from 'swiper/js/swiper'

document.addEventListener('DOMContentLoaded', () => {
  let mySwiper = []
  for (let step = 1; step < 11; step++) {
    mySwiper.push(new Swiper(`.swiper-container-${step}`, {}))
    console.log(`.swiper-container-${step}`)
  }
})
