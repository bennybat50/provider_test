import 'package:flutter/material.dart';

class AppBloc extends ChangeNotifier {
  String _errorMsg, _successMsg;
  List _kitchens = [],districts=[],
      _dishes = [],
      _pendingOrders = [],
      _inTransitOrders = [],
      _acceptedOrders = [],
      _rejectedOrders = [],
      _readyOrders = [],
      _deliveredOrders = [];
  int _pageIndex = 0;
  var _mapSuccess,
      _kIndex = 0,
      _currency,
      _selectedKitchen = '',
      _aDish,
      _cart,
      _savedDishes = {},
      _cartDishes = {},
      _cachedDish = {};

  bool sent,
      upload,
      exits,
      _hasCartDishes = false,
      _hasPendingOrder = false,
      _hasAcceptedOrder = false,
      _hasRejectedOrder = false,
      _hasIntransitOrders = false,
      _hasReadyOrder = false,
      _hasDeliveredOrder = false,
      _hasKitchens = false,
      _hasDishes = false,
      _hasCart = false;

  get errorMsg => _errorMsg;
  get successMsg => _successMsg;
  get mapSuccess => _mapSuccess;
  get hasKitchens => _hasKitchens;
  get hasDishes => _hasDishes;
  get currency => _currency;
  get kitchens => _kitchens;
  get kIndex => _kIndex;
  get dishes => _dishes;
  get pendingOrders => _pendingOrders;
  get cart => _cart;
  get selectedKitchen => _selectedKitchen;
  get aDish => _aDish;
  get hasCart => _hasCart;
  get hasPendingOrder => _hasPendingOrder;
  get savedDishes => _savedDishes;
  get cachedDish => _cachedDish;
  get pageIndex => _pageIndex;
  get cartDishes => _cartDishes;
  get hasCartDishes => _hasCartDishes;
  get inTransitOrders => _inTransitOrders;
  get hasIntransitOrders => _hasIntransitOrders;


    set inTransitOrders(value) {
    _inTransitOrders = value;
    notifyListeners();
  }
  set hasIntransitOrders(value) {
    _hasIntransitOrders = value;
    notifyListeners();
  }
  set hasCartDishes(value) {
    _hasCartDishes = value;
    notifyListeners();
  }

  set cartDishes(value) {
    _cartDishes = value;
    notifyListeners();
  }

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  set cachedDish(value) {
    _cachedDish = value;
    notifyListeners();
  }

  set hasPendingOrder(value) {
    _hasPendingOrder = value;
    notifyListeners();
  }

  set savedDishes(value) {
    _savedDishes = value;
    notifyListeners();
  }

  set hasCart(value) {
    _hasCart = value;
    notifyListeners();
  }

  set aDish(value) {
    _aDish = value;
    notifyListeners();
  }

  set selectedKitchen(value) {
    _selectedKitchen = value;
    notifyListeners();
  }

  set currency(value) {
    _currency = value;
    notifyListeners();
  }

  set cart(value) {
    _cart = value;
    notifyListeners();
  }

  set hasDishes(value) {
    _hasDishes = value;
    notifyListeners();
  }

  set kIndex(value) {
    _kIndex = value;
    notifyListeners();
  }

  set kitchens(List value) {
    _kitchens = value;
    notifyListeners();
  }

  set mapSuccess(value) {
    _mapSuccess = value;
    notifyListeners();
  }

  set errorMsg(value) {
    _errorMsg = value;
    notifyListeners();
  }

  set hasKitchens(value) {
    _hasKitchens = value;
    notifyListeners();
  }

  set dishes(value) {
    _dishes = value;
    notifyListeners();
  }

  set pendingOrders(value) {
    _pendingOrders = value;
    notifyListeners();
  }

  get rejectedOrders => _rejectedOrders;

  set rejectedOrders(value) {
    _rejectedOrders = value;
    notifyListeners();
  }

  get readyOrders => _readyOrders;

  set readyOrders(value) {
    _readyOrders = value;
    notifyListeners();
  }

  get deliveredOrders => _deliveredOrders;

  set deliveredOrders(value) {
    _deliveredOrders = value;
    notifyListeners();
  }

  get acceptedOrders => _acceptedOrders;

  set acceptedOrders(value) {
    _acceptedOrders = value;
    notifyListeners();
  }

  get hasAcceptedOrder => _hasAcceptedOrder;

  set hasAcceptedOrder(value) {
    _hasAcceptedOrder = value;
    notifyListeners();
  }

  get hasRejectedOrder => _hasRejectedOrder;

  set hasRejectedOrder(value) {
    _hasRejectedOrder = value;
    notifyListeners();
  }

  get hasReadyOrder => _hasReadyOrder;

  set hasReadyOrder(value) {
    _hasReadyOrder = value;
    notifyListeners();
  }

  get hasDeliveredOrder => _hasDeliveredOrder;

  set hasDeliveredOrder(value) {
    _hasDeliveredOrder = value;
    notifyListeners();
  }
}
