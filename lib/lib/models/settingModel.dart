
class SettingModelList {
  final List<SettingModel> list;

  SettingModelList({required this.list});
  factory SettingModelList.fromJson(List<dynamic> json) {
    List<SettingModel> list =json.map((data) => SettingModel.fromJson(data)).toList();
    return SettingModelList(list: list);
  }
}

class SettingModel {
    String remaintime;
    int remaingame;
    int minbet;
    int maxbet;
    int run;
    DateTime lastupdate;
    int gamenumber;
    String roundtext;
    String gametext;
    int buyin;

    SettingModel({
        required this.remaintime,
        required this.remaingame,
        required this.minbet,
        required this.maxbet,
        required this.run,
        required this.lastupdate,
        required this.gamenumber,
        required this.roundtext,
        required this.gametext,
        required this.buyin,
    });

    factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
        remaintime: json["remaintime"],
        remaingame: json["remaingame"],
        minbet: json["minbet"],
        maxbet: json["maxbet"],
        run: json["run"],
        lastupdate: DateTime.parse(json["lastupdate"]),
        gamenumber: json["gamenumber"],
        roundtext: json["roundtext"],
        gametext: json["gametext"],
        buyin: json["buyin"],
    );

    Map<String, dynamic> toJson() => {
        "remaintime": remaintime,
        "remaingame": remaingame,
        "minbet": minbet,
        "maxbet": maxbet,
        "run": run,
        "lastupdate": lastupdate.toIso8601String(),
        "gamenumber": gamenumber,
        "roundtext": roundtext,
        "gametext": gametext,
        "buyin": buyin,
    };
}