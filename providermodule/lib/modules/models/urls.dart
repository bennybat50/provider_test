class Urls {
  static String offlineIP = 'http://192.168.1.3',
      onlineIP = 'http://206.189.124.254',
      domain = 'https://kitchly.co/api/v1',
      ip = domain,
      port1 = '$ip:6000/api/v1',
      port3 = '$ip:6003/api/v1',
      port4 = '$ip:6004/api/v1',
      port5 = '$ip:6005/api/v1',
      port6 = '$ip:6006/api/v1';
     static bool isLive=true;
  //URLS
  static String login = "${isLive?ip:port1}/users/signin",
      create = "${isLive?ip:port1}/users",
      verify = "${isLive?ip:port1}/users/verify",
      resendCode = "${isLive?ip:port1}/users/resend/code",
      resetPassword = "${isLive?ip:port1}/users/reset/account",
      logOut = "${isLive?ip:port3}/users/logout",
      getDistricts = "${isLive?ip:port3}/q/districts",
      getCountries = "${isLive?ip:port3}/q/countries",
      getStates = "${isLive?ip:port3}/q/states",
      getRegionKitchens = "${isLive?ip:port3}/kitchens/regions",
      getKitchenDishes = "${isLive?ip:port3}/dishes/info", 
      getOrderss="${isLive?ip:port5}/orders",
      getUserOrders = "${isLive?ip:port5}/orders/user",
      getOrderStatus = "${isLive?ip:port5}/orders/status",
      rejectOrders = "${isLive?ip:port5}/orders/reject",
      getUserCart = "${isLive?ip:port6}/carts",
      addCart = "${isLive?ip:port6}/carts/add",
      cartDish = "${isLive?ip:port6}/carts/dishes/",
      cartExtras = "${isLive?ip:port6}/carts/extras/",
      deleteCart = "${isLive?ip:port6}/carts/remove",
      deleteCartDish = "${isLive?ip:port6}/carts/remove/dish",
      deleteCartExtra = "${isLive?ip:port6}/carts/remove/extra",
      cartCheckOut = "${isLive?ip:port6}/carts/checkout";
}
