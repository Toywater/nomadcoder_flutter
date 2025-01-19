class MovieDetailModel {
  late dynamic id;
  late String genre;
  late int runtime;

  MovieDetailModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    runtime = json["runtime"];

    List<String> tmpList = [];

    // 장르는 Map<dynamic, String> 으로 되어 있으므로 콤마 스트링으로 변환
    for (var jsonItem in json["genres"]) {
      tmpList.add(jsonItem["name"]);
    }

    final sb = StringBuffer();
    sb.writeAll(tmpList, ', ');
    genre = sb.toString();
  }
}
