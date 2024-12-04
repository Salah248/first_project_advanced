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
  String link;

  Contacts(
    this.phone,
    this.email,
    this.link,
  );
}

class Authentiction {
  Customer? customer;
  Contacts? contacts;

  Authentiction(
    this.contacts,
    this.customer,
  );
}


class Service {
  String id ;
  String title ;
  String image ;

  Service(
   this.id ,
   this.title,
   this.image
  );
}

class Store {
  String id;
  String title;
  String image;

  Store(this.id, this.title, this.image);
}

class BannerAd {
  String id;
  String title;
  String image;
  String link;

  BannerAd(this.id, this.title, this.image, this.link);
}

class HomeData {
  List<Service> services;
  List<BannerAd> banners;
  List<Store> stores;

  HomeData(this.services, this.banners, this.stores);
}

class HomeObject {
  HomeData data;

  HomeObject(this.data);
}
