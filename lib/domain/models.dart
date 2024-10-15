// onboarding models

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.image, this.subTitle);
}

class SliderViewObject {
  SliderObject sliderOpject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderOpject, this.currentIndex, this.numOfSlides);
}
