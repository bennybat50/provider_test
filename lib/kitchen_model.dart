// To parse this JSON data, do
//
//     final kitchensModel = kitchensModelFromJson(jsonString);

import 'dart:convert';

KitchensModel kitchensModelFromJson(String str) => KitchensModel.fromJson(json.decode(str));

String kitchensModelToJson(KitchensModel data) => json.encode(data.toJson());

class KitchensModel {
    KitchensModel({
        this.kitchens,
        this.paginate,
    });

    List<Kitchen> kitchens;
    Paginate paginate;

    factory KitchensModel.fromJson(Map<String, dynamic> json) => KitchensModel(
        kitchens: json["kitchens"] == null ? null : List<Kitchen>.from(json["kitchens"].map((x) => Kitchen.fromJson(x))),
        paginate: json["paginate"] == null ? null : Paginate.fromJson(json["paginate"]),
    );

    Map<String, dynamic> toJson() => {
        "kitchens": kitchens == null ? null : List<dynamic>.from(kitchens.map((x) => x.toJson())),
        "paginate": paginate == null ? null : paginate.toJson(),
    };
}

class Kitchen  {
    Kitchen({
        this.userId,
        this.kitchenId,
        this.kitchenName,
        this.email,
        this.routeName,
        this.routeUrl,
        this.rating,
        this.caption,
        this.isActive,
        this.openForOrder,
        this.addr,
        this.position,
        this.profile,
        this.small,
        this.large,
        this.views,
        this.tour,
        this.openings,
    });

    String userId;
    String kitchenId;
    String kitchenName;
    String email;
    String routeName;
    String routeUrl;
    int rating;
    String caption;
    bool isActive;
    bool openForOrder;
    String addr;
    Position position;
    String profile;
    String small;
    String large;
    Map<String, String> views;
    String tour;
    dynamic openings;

    factory Kitchen.fromJson(Map<String, dynamic> json) => Kitchen(
        userId: json["user_id"] == null ? null : json["user_id"],
        kitchenId: json["kitchen_id"] == null ? null : json["kitchen_id"],
        kitchenName: json["kitchen_name"] == null ? null : json["kitchen_name"],
        email: json["email"] == null ? null : json["email"],
        routeName: json["route_name"] == null ? null : json["route_name"],
        routeUrl: json["route_url"] == null ? null : json["route_url"],
        rating: json["rating"] == null ? null : json["rating"],
        caption: json["caption"] == null ? null : json["caption"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        openForOrder: json["open_for_order"] == null ? null : json["open_for_order"],
        addr: json["addr"] == null ? null : json["addr"],
        position: json["position"] == null ? null : Position.fromJson(json["position"]),
        profile: json["profile"] == null ? null : json["profile"],
        small: json["small"] == null ? null : json["small"],
        large: json["large"] == null ? null : json["large"],
        views: json["views"] == null ? null : Map.from(json["views"]).map((k, v) => MapEntry<String, String>(k, v)),
        tour: json["tour"] == null ? null : json["tour"],
        openings: json["openings"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "kitchen_id": kitchenId == null ? null : kitchenId,
        "kitchen_name": kitchenName == null ? null : kitchenName,
        "email": email == null ? null : email,
        "route_name": routeName == null ? null : routeName,
        "route_url": routeUrl == null ? null : routeUrl,
        "rating": rating == null ? null : rating,
        "caption": caption == null ? null : caption,
        "is_active": isActive == null ? null : isActive,
        "open_for_order": openForOrder == null ? null : openForOrder,
        "addr": addr == null ? null : addr,
        "position": position == null ? null : position.toJson(),
        "profile": profile == null ? null : profile,
        "small": small == null ? null : small,
        "large": large == null ? null : large,
        "views": views == null ? null : Map.from(views).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "tour": tour == null ? null : tour,
        "openings": openings,
    };
}

class OpeningsClass {
    OpeningsClass({
        this.monday,
        this.tuesday,
        this.wednesday,
        this.friday,
        this.saturday,
        this.sunday,
    });

    List<Day> monday;
    List<Day> tuesday;
    List<Day> wednesday;
    List<Day> friday;
    List<Day> saturday;
    List<Day> sunday;

    factory OpeningsClass.fromJson(Map<String, dynamic> json) => OpeningsClass(
        monday: json["monday"] == null ? null : List<Day>.from(json["monday"].map((x) => Day.fromJson(x))),
        tuesday: json["tuesday"] == null ? null : List<Day>.from(json["tuesday"].map((x) => Day.fromJson(x))),
        wednesday: json["wednesday"] == null ? null : List<Day>.from(json["wednesday"].map((x) => Day.fromJson(x))),
        friday: json["friday"] == null ? null : List<Day>.from(json["friday"].map((x) => Day.fromJson(x))),
        saturday: json["saturday"] == null ? null : List<Day>.from(json["saturday"].map((x) => Day.fromJson(x))),
        sunday: json["sunday"] == null ? null : List<Day>.from(json["sunday"].map((x) => Day.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "monday": monday == null ? null : List<dynamic>.from(monday.map((x) => x.toJson())),
        "tuesday": tuesday == null ? null : List<dynamic>.from(tuesday.map((x) => x.toJson())),
        "wednesday": wednesday == null ? null : List<dynamic>.from(wednesday.map((x) => x.toJson())),
        "friday": friday == null ? null : List<dynamic>.from(friday.map((x) => x.toJson())),
        "saturday": saturday == null ? null : List<dynamic>.from(saturday.map((x) => x.toJson())),
        "sunday": sunday == null ? null : List<dynamic>.from(sunday.map((x) => x.toJson())),
    };
}

class Day {
    Day({
        this.time,
        this.period,
    });

    String time;
    Period period;

    factory Day.fromJson(Map<String, dynamic> json) => Day(
        time: json["time"] == null ? null : json["time"],
        period: json["period"] == null ? null : periodValues.map[json["period"]],
    );

    Map<String, dynamic> toJson() => {
        "time": time == null ? null : time,
        "period": period == null ? null : periodValues.reverse[period],
    };
}

enum Period { AM }

final periodValues = EnumValues({
    "am": Period.AM
});

class Position {
    Position({
        this.longitude,
        this.latitude,
    });

    double longitude;
    double latitude;

    factory Position.fromJson(Map<String, dynamic> json) => Position(
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
    };
}

class Paginate {
    Paginate({
        this.current,
        this.pages,
        this.total,
        this.showing,
    });

    int current;
    int pages;
    int total;
    Showing showing;

    factory Paginate.fromJson(Map<String, dynamic> json) => Paginate(
        current: json["current"] == null ? null : json["current"],
        pages: json["pages"] == null ? null : json["pages"],
        total: json["total"] == null ? null : json["total"],
        showing: json["showing"] == null ? null : Showing.fromJson(json["showing"]),
    );

    Map<String, dynamic> toJson() => {
        "current": current == null ? null : current,
        "pages": pages == null ? null : pages,
        "total": total == null ? null : total,
        "showing": showing == null ? null : showing.toJson(),
    };
}

class Showing {
    Showing({
        this.from,
        this.to,
    });

    int from;
    int to;

    factory Showing.fromJson(Map<String, dynamic> json) => Showing(
        from: json["from"] == null ? null : json["from"],
        to: json["to"] == null ? null : json["to"],
    );

    Map<String, dynamic> toJson() => {
        "from": from == null ? null : from,
        "to": to == null ? null : to,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
