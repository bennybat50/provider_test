import 'package:intl/intl.dart';

class MoneyConverter {
  final oCcy = NumberFormat("#,##0.00", "en_US");

  convert(x) {
    if (x != null) {
      x = double.parse(x.toString());
      return oCcy.format(x);
    } else {
      return "0.00";
    }
  }

   getCount({n}){
    if(n.toString().length <=6){
      return 40.0;
    }
    if(n.toString().length <=9){
      return 35.0;
    }
    if(n.toString().length <=12){
      return 30.0;
    }
    if(n.toString().length <=15){
      return 25.0;
    }
    if(n.toString().length <=18){
      return 20.0;
    }
    if(n.toString().length <=21){
      return 17.0;
    }
    if(n.toString().length > 24){
      return 12.0;
    }
  }
}
