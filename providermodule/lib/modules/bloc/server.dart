import 'package:http/http.dart' as http;
import 'package:providermodule/providermodule.dart';
import 'package:request/request.dart';

import 'app_bloc.dart';

class Server {
  Request _request = Request();

  Future getKitchens({AppBloc appBloc, data}) async {
    String gotResponse;
    if (PublicVar.useServer) {
      if (await postAction(
          bloc: appBloc, url: Urls.getRegionKitchens, data: data)) {
        appBloc.kitchens = appBloc.mapSuccess['kitchens'];
        await Server().getUserCart(
            appBloc: appBloc, data: {"user_id": PublicVar.userKitchlyID});
        gotResponse = 'true';
        appBloc.hasKitchens = true;
      } else {
        gotResponse = 'false';
        appBloc.hasKitchens = false;
      }
    } else {
      await Future.delayed(Duration(milliseconds: 1), () async {
        await getUserCart(appBloc: appBloc, data: data);
        appBloc.kitchens = PublicData.kitchenList['kitchens'];
        appBloc.hasKitchens = true;
        gotResponse = 'true';
      });
    }
    return gotResponse;
  }

  Future getKitchenDishes({AppBloc appBloc, var data}) async {
    String gotResponse;
    
      var kitchenId = data['query']['kitchen_id'];

      if (PublicVar.useServer) {
        //Use Server
        
        if (appBloc.cachedDish[kitchenId] == null) {
          //Check Cached Data
          if (await postAction(
              bloc: appBloc, url: Urls.getKitchenDishes, data: data)) {
            if (appBloc.mapSuccess['currency']['symbol'] != null) {
              print('Yes Currency');
              appBloc.currency = appBloc.mapSuccess['currency']['symbol'];
            } else {
              print('No Currency');
              appBloc.currency = "";
            }
            appBloc.dishes = appBloc.mapSuccess['dishes'];

            appBloc.cachedDish.addAll({
              kitchenId: {
                'dishes': appBloc.dishes,
                'currency': appBloc.currency
              }
            });
            gotResponse = 'true';
            appBloc.hasDishes = true;
          } else {
            gotResponse = "false";
            appBloc.hasDishes = false;
          }
        } else {
          await Future.delayed(Duration(milliseconds: 0), () async {
            appBloc.dishes = appBloc.cachedDish[kitchenId]['dishes'];
            appBloc.currency = appBloc.cachedDish[kitchenId]['currency'];
            appBloc.hasDishes = true;
            gotResponse = 'true';
             });
        }
      } else {

        if (appBloc.cachedDish[kitchenId] == null) {
          appBloc.mapSuccess = PublicData.dishes[kitchenId];
          appBloc.currency = appBloc.mapSuccess['currency']['symbol'];
          appBloc.dishes = appBloc.mapSuccess['dishes'];
          appBloc.cachedDish.addAll({
            kitchenId: {
              'dishes': appBloc.dishes,
              'currency': appBloc.currency
            }
          });
        } else {
          appBloc.dishes = appBloc.cachedDish[kitchenId]['dishes'];
          appBloc.currency = appBloc.cachedDish[kitchenId]['currency'];
        }

        appBloc.hasDishes = true;
        gotResponse = 'true';
      }
   
    return gotResponse;
  }

  Future getUserCart({AppBloc appBloc, data}) async {
    String gotResponse;
    await Future.delayed(Duration(milliseconds: 1), ()async {
    if (PublicVar.useServer) {
      if (await postAction(bloc: appBloc, url: Urls.getUserCart, data: data)) {
        appBloc.cart = appBloc.mapSuccess;
        appBloc.currency = appBloc.cart['currency']['symbol'];
        gotResponse = 'true';
        appBloc.hasCart = true;
      } else {
        appBloc.cart = {};
        gotResponse = 'false';
        appBloc.hasCart = false;
      }
    } else {
       appBloc.cart = PublicData.cart;
        appBloc.currency = appBloc.cart['currency']['symbol'];     
        appBloc.hasCart = true;
        gotResponse = 'true';
    }
    
    if (appBloc.cart['items'] != null &&
        appBloc.cart['items'].length > 0 &&
        !appBloc.hasCartDishes) {
      var cartItems = appBloc.cart['items'];
       appBloc.cartDishes={};
      for (var i = 0; i < cartItems.length; i++) {
        if (appBloc.cartDishes[cartItems[i]['dish_id']] == null) {
          appBloc.cartDishes.addAll({cartItems[i]['dish_id']: cartItems[i]['quantity']});
        } else {
          appBloc.cartDishes[cartItems[i]['dish_id']] = appBloc.cartDishes[cartItems[i]['dish_id']] + cartItems[i]['quantity'];
        }
      }
      appBloc.hasCartDishes = true;
    }else if (appBloc.cart['items'] == null){
      appBloc.cartDishes={};
    }
 });
    return gotResponse;
  }

  Future getPendingOrders({AppBloc appBloc, data}) async {
    String gotResponse;
    if (PublicVar.useServer) {
      if (await postAction(
          bloc: appBloc, url: Urls.getUserOrders, data: data)) {
        appBloc.pendingOrders = appBloc.mapSuccess['data'];
        gotResponse = 'true';
        appBloc.hasPendingOrder = true;
      } else {
        gotResponse = 'false';
        appBloc.hasPendingOrder = false;
      }
    } else {
      await Future.delayed(Duration(seconds: 1), () {
        appBloc.pendingOrders = PublicData.ordersList['data'];
      });
      appBloc.hasPendingOrder = true;
      gotResponse = "true";
    }
    return gotResponse;
  }
  Future getAcceptedOrders({AppBloc appBloc, data}) async {
    String gotResponse;
    if (PublicVar.useServer) {
      if (await postAction(
          bloc: appBloc, url: Urls.getUserOrders, data: data)) {
        appBloc.acceptedOrders = appBloc.mapSuccess['data'];
        gotResponse = 'true';
        appBloc.hasAcceptedOrder = true;
      } else {
        gotResponse = 'false';
        appBloc.hasAcceptedOrder = false;
      }
    } else {
      await Future.delayed(Duration(milliseconds: 1), () {
        appBloc.acceptedOrders =  PublicData.ordersList['data'];
      });
      appBloc.hasAcceptedOrder = true;
      gotResponse = "true";
    }
    return gotResponse;
  }
  Future getRejectedOrders({AppBloc appBloc, data}) async {
    String gotResponse;
    if (PublicVar.useServer) {
      if (await postAction(
          bloc: appBloc, url: Urls.getUserOrders, data: data)) {
        appBloc.rejectedOrders = appBloc.mapSuccess['data'];
        gotResponse = 'true';
        appBloc.hasRejectedOrder = true;
      } else {
        gotResponse = 'false';
        appBloc.hasRejectedOrder = false;
      }
    } else {
      await Future.delayed(Duration(milliseconds: 1), () {
        appBloc.rejectedOrders = PublicData.ordersList['data'];
      });
      appBloc.hasRejectedOrder = true;
      gotResponse = "true";
    }
    return gotResponse;
  }

  Future getIntransitOrders({AppBloc appBloc, data}) async {
    String gotResponse;
    if (PublicVar.useServer) {
      if (await postAction(
          bloc: appBloc, url: Urls.getUserOrders, data: data)) {
        appBloc.inTransitOrders= appBloc.mapSuccess['data'];
        gotResponse = 'true';
        appBloc.hasIntransitOrders = true;
      } else {
        gotResponse = 'false';
        appBloc.hasIntransitOrders = false;
      }
    } else {
      await Future.delayed(Duration(milliseconds: 1), () {
        appBloc.inTransitOrders = PublicData.ordersList['data'];
      });
      appBloc.hasIntransitOrders = true;
      gotResponse = "true";
    }
    return gotResponse;
  }

  Future getReadyOrders({AppBloc appBloc, data}) async {
    String gotResponse;
    if (PublicVar.useServer) {
      if (await postAction(
          bloc: appBloc, url: Urls.getUserOrders, data: data)) {
        appBloc.readyOrders = appBloc.mapSuccess['data'];
        gotResponse = 'true';
        appBloc.hasReadyOrder = true;
      } else {
        gotResponse = 'false';
        appBloc.hasRejectedOrder = false;
      }
    } else {
      await Future.delayed(Duration(milliseconds: 1), () {
        appBloc.readyOrders = PublicData.ordersList['data'];
      });
      appBloc.hasReadyOrder = true;
      gotResponse = "true";
    }
    return gotResponse;
  }

  Future getDeliveredOrders({AppBloc appBloc, data}) async {
    String gotResponse;
    if (PublicVar.useServer) {
      if (await postAction(
          bloc: appBloc, url: Urls.getUserOrders, data: data)) {
        appBloc.deliveredOrders = appBloc.mapSuccess['data'];
        gotResponse = 'true';
        appBloc.hasDeliveredOrder = true;
      } else {
        gotResponse = 'false';
        appBloc.hasDeliveredOrder = false;
      }
    } else {
      await Future.delayed(Duration(milliseconds: 1), () {
        appBloc.deliveredOrders = PublicData.ordersList['data'];
      });
      appBloc.hasDeliveredOrder = true;
      gotResponse = "true";
    }
    return gotResponse;
  }

  uploadImg<bool>({AppBloc appBloc, url, Map data}) async {
    try {
      List fields = data.keys.toList();
      List files = data.values.toList();
      var request = http.MultipartRequest("PUT", Uri.parse(url));
      for (var i = 0; i < fields.length; i++) {
        var pic = await http.MultipartFile.fromPath(
          fields[i],
          files[i].path,
        );
        request.files.add(pic);
      }
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(responseString);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> postAction({AppBloc bloc, String url, var data}) async {
    bool sent;
    try {
      await _request.post(url, data, (res) {
        if (getDataType(res) &&Error().getStatus(status: res["type"])) {
          PublicVar.errorResponse = res["msg"];
          sent = false;
        } else {
          PublicVar.successResponse = res;
          sent = true;
        }
      });
    } catch (e) {
      print('Post error ${e.toString()} url:');
     PublicVar.errorResponse = PublicVar.serverError;
      sent = false;
    }
    return sent;
  }

   Future postActionS({ String url, var data}) async {
    var response;
    try {
      await _request.post(url, data, (res) {
        response=res;
      });
    } catch (e) {
      print('Post error ${e.toString()} url:');
     
    }
    return response;
  }

  

  Future<bool> putAction({AppBloc bloc, String url, var data}) async {
    bool sent = false;
    try {
      await _request.put(url, data, (res) {
        if (Error().getStatus(status: res["type"])) {
          sent = false;
          bloc.errorMsg = res["msg"];
        } else {
          sent = true;
        }
      });
    } catch (e) {
      print('Put error ${e.toString()}');
      bloc.errorMsg = PublicVar.serverError;
      sent = false;
    }
    return sent;
  }

  Future<bool> deleteAction({AppBloc bloc, String url, var data}) async {
    bool sent = false;
    try {
      await _request.delete(url, data, (res) {
        if (Error().getStatus(status: res["type"])) {
          sent = false;
          bloc.errorMsg = res["msg"];
        } else {
          sent = true;
        }
      });
    } catch (e) {
      print('delete error ${e.toString()}');
      bloc.errorMsg = PublicVar.serverError;
      sent = false;
    }
    return sent;
  }

  Future<bool> getAction({AppBloc appBloc, String url}) async {
    bool sent = false;
    try {
      var data = await _request.getRoute(url);
      if (data != null) {
        appBloc.mapSuccess = data;
        sent = true;
      } else {
        sent = false;
      }
    } catch (e) {
      print('get error ${e.toString()}');
      appBloc.errorMsg = PublicVar.serverError;
      sent = false;
    }
    return sent;
  }

   getDataType(data) {
    var has = false;
    if (data.runtimeType.toString() ==
        "_InternalLinkedHashMap<String, dynamic>") {
      has = true;
    }
    return has;
  }
}
