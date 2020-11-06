import 'package:app_provider1/kitchen_model.dart';
import 'package:flutter/cupertino.dart';


class ProviderClass extends ChangeNotifier{
  bool isLoading =true;
  KitchensModel _kitchensModel=KitchensModel();
  List<Kitchen> kitchenList=List();

  ProviderClass(){
    _kitchensModel.kitchens=kitchenList;
    //kljlkll;lkjkljjkl
  }

  setData(KitchensModel kitchensModel){
    _kitchensModel=kitchensModel;
    isLoading=false;
    notifyListeners();
  }

  KitchensModel getKitchens(){
    return _kitchensModel;
  }

 

}