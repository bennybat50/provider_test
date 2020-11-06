import 'dart:async';
import 'dart:convert';
import 'package:app_provider1/kitchen_model.dart';
import 'package:app_provider1/provider_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providermodule/providermodule.dart';
import 'google_login.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderClass>.value(value: ProviderClass())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorObservers: [observer],
        home: MyHomePage(
          title: 'Flutter Demo Home Page',
          observer: observer,
          analytics: analytics,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  MyHomePage({Key key, this.title, this.analytics, this.observer})
      : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Kitchen> kitchens;
  KitchensModel kitchensModel;
  ProviderClass providerClass;

  Future<Null> currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: "Home View",
        screenClassOverride: "Home View as per overide");
  }

  Future<Null> sendAnalytics() async {
    await widget.analytics.logEvent(
        name: "Move_first_screen",
        parameters: <String, dynamic>{"user": "This is user Young Batimehin"});
    AppActions().showSuccessToast(text: "Event Sent");
  }

  Future<Iterable> fetchMultiple() async {
    var url = '${Urls.getOrderss}/kitchen';
    Map data = {
      "query": {"kitchen_id": "9y17gx69zkfprql9k", "status": "PENDING"},
      "page": 1,
      "limit": 100,
      "token": PublicVar.getToken
    };
    Map data2 = {
      "query": {"kitchen_id": "9y17gx69zkfprql9k", "status": "IN_TRANSIT"},
      "page": 1,
      "limit": 100,
      "token": PublicVar.getToken
    };

    var responses = await Future.wait([
      Server().postActionS(
        data: data,
        url: url,
      ),
      
      Server().postActionS(
        data: data2,
        url: url,
      ),
      
    ]);
    var ress = {};
    var rss=[];
    for (var i = 0; i < responses.length; i++) {
      switch (i) {
        case 0:
          ress.addAll({"pending": responses[i]['data']});
          break;
        case 1:
          ress.addAll({"in_transit": responses[i]['data']});
          break;
        
      }
    }
    print(ress['pending']);
    print(ress['in_transit']);
   
  }

  Future<void> _initializeFlutterFireFuture;
  final _kShouldTestAsyncErrorOnInit = false;
// Toggle this for testing Crashlytics in your app locally.
  final _kTestingCrashlytics = true;

  @override
  void initState() {
    hitApi();
    currentScreen();
    _initializeFlutterFireFuture = _initializeFlutterFire();
    super.initState();
  }

  Future<void> _testAsyncErrorOnInit() async {
    Future<void>.delayed(const Duration(seconds: 2), () {
      final List<int> list = <int>[];
      print(list[100]);
    });
  }

  // Define an async function to initialize FlutterFire
  Future<void> _initializeFlutterFire() async {
    // Wait for Firebase to initialize
    await Firebase.initializeApp();

    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }

    // Pass all uncaught errors to Crashlytics.
    Function originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      // Forward to original handler.
      originalOnError(errorDetails);
    };

    if (_kShouldTestAsyncErrorOnInit) {
      await _testAsyncErrorOnInit();
    }
  }

  hitApi() async {
    Future.delayed(Duration(milliseconds: 1), () async {
      kitchensModel = await getData();
      kitchens = kitchensModel.kitchens;
      providerClass.setData(kitchensModel);
      print(providerClass.getKitchens().kitchens[1].addr);
    });
  }

  Future<KitchensModel> getData() async {
    Map data = {"query": PublicVar.setLocation, "page": 1, "limit": 100};
    var res = await Server().postActionS(
      data: data,
      url: Urls.getRegionKitchens,
    );
    kitchensModel = KitchensModel.fromJson(res);
    return kitchensModel;
  }

  @override
  Widget build(BuildContext context) {
    providerClass = Provider.of<ProviderClass>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(
                Icons.network_cell,
              ),
              onPressed: () {
                NextPage().nextRoute(context, LoginGoogle());
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          RaisedButton(
              child: const Text('Test multiple request'),
              onPressed: () async {
                fetchMultiple();
              }),
          RaisedButton(
              child: const Text('Send Analytics'),
              onPressed: () async {
                sendAnalytics();
              }),
          RaisedButton(
              child: const Text('Crash'),
              onPressed: () async {
                FirebaseCrashlytics.instance.crash();
              }),
          RaisedButton(
              child: const Text('Throw Error'),
              onPressed: () {
                throw StateError('Uncaught error thrown by app');
              }),
          ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: providerClass.getKitchens().kitchens.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.network(
                      providerClass.getKitchens().kitchens[index].profile),
                  title: Text(
                      providerClass.getKitchens().kitchens[index].kitchenName),
                  onTap: () {
                    kitchens[index].kitchenName = "My Kitchens";
                    providerClass.setData(kitchensModel);
                  },
                );
              })
        ]),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
