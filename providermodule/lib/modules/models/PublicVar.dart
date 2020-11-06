import 'dart:io';

class PublicVar {
  static int userId, userPin;
  static String userName,
      firstName,
      lastName,
      userEmail,
      userPhone,
      userPass,
      userGender,
      userProfilePic,
      userProfileLink,
      userDOB,
      userCountry,
      userZipCode,
      userKitchlyID,
      userPinCode,
      userImageStatus,
      userStatus,
      userAddress,
      distance,
      getToken,
      kitchenID,
      kitchenName,
      kitchenUserName,
      kitchenCaption,
      kitchenLocation,
      kitchenTime,
      kitchenVideoUrl,
      kitchenVideoPath,
      kitchenImageUrl,
      kitchenImagePath;

  static bool accountApproved, firstRegistration, firstVerification;

  static Map setLocation = {"region": "maitama", "state": "abuja"};

  static var successResponse,errorResponse;


  //Defaults
  static int primaryColor = 0XFF34D186;

  static int white = 0XFFFFFFFF;

  static int nameColor = 0xff333636;

  static int black = 0XFF000000;

  static Map deviceMap;

  static Map appMap;

  static Future futureImages,
      futureVideos,
      futureMessages,
      futureNotifications,
      futureUserStatus,
      futurePartnerStatus;

  static List chatMessages = List();

  static List images;

  static String imageUploadPath;

  static File uploadFile, userFileImg, kitchenTourFile;

  static bool useServer;

  static String defaultFoodImage = "assets/images/icons/dishHolder.png";

  static String defaultKitchenImage = "assets/images/kitchenDefault.jpg";

  static String galleryErrorImage =
      "assets/images/userBackground.jpg"; //image_error.png

  static String videoPlace = "assets/images/video_place.png";

  static String defaultOnlineImage =
      "https://images.unsplash.com/photo-1508717272800-9fff97da7e8f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=751&q=80";

  //Select User Photo
  static String setUser;

  //Select ImageSource
  static String setSource;

  static String page1 = "1", page2 = "2", page3 = "3", page4 = "4";

  static String noImage = "No Moment's yet,\nShare a moment or Reload",
      selectVideo = "You have not selected a video ",
      noNotification = "No Notifications ",
      noComment = "No Comments yet,\nSend a Comments or Reload",
      noMessage = "No Messages yet,\nSend a message or Reload",
      checkInternet = "Please check your internet connection\nthen try again",
      serverError = 'Oops something went wrong from our side, please try again',
      wait = 'One moment please....',
      requestErrorString = "Ooops Something went wrong!!\ntry again";
}
