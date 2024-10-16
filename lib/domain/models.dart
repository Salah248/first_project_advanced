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

// login models

class Customer {
  String id;
  String name;
  int numOfNotification;

  Customer(
    this.id,
    this.name,
    this.numOfNotification,
  );
}

class Contacts {
  String phone;
  String email;
  int link;

  Contacts(
    this.phone,
    this.email,
    this.link,
  );
}

class Authentiction {
  Customer customer;
  Contacts contacts;

  Authentiction(
    this.contacts,
    this.customer,
  );
}
