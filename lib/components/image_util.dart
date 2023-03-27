class ImageUtil {

  static const String  vitalImagePath = "assets/vitals/";
  static const String  healthProfileImagePath = "assets/images/health_profile/";
  static const String  baseImagePath =  "assets/images/";

  static String logoImage = "logo.svg";

  static String lensIcon = "lens-icon.svg";
  static String cartIcon = "cart-icon.svg";
  static String messageIcon = "message-icon.svg";

  static getImage(String image) {
    // debugPrint('>>>>>>>${baseImagePath + image}');
    return baseImagePath + image;
  }

  static getHealthProfileImage(String image) {
    return healthProfileImagePath + image;
  }

  static getVitalsImage(String image) {
    // debugPrint('>>>>>>>${vitalImagePath + image}');

    return vitalImagePath + image;
  }
}
