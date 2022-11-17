class GetImagesModel {
  GetImagesModel({
      List<Hits>? hits,}){
    _hits = hits;
}

  GetImagesModel.fromJson(dynamic json) {
    if (json['hits'] != null) {
      _hits = [];
      json['hits'].forEach((v) {
        _hits?.add(Hits.fromJson(v));
      });
    }
  }
  List<Hits>? _hits;

  List<Hits>? get hits => _hits;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_hits != null) {
      map['hits'] = _hits?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Hits {
  Hits({
      String? previewURL,
      String? largeImageURL,}){
    _previewURL = previewURL;
    _largeImageURL = largeImageURL;
}

  Hits.fromJson(dynamic json) {
    _previewURL = json['previewURL'];
    _largeImageURL = json['largeImageURL'];
  }
  String? _previewURL;
  String? _largeImageURL;

  String? get previewURL => _previewURL;
  String? get largeImageURL => _largeImageURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['previewURL'] = _previewURL;
    map['largeImageURL'] = _largeImageURL;
    return map;
  }

}