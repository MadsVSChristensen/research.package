part of research_package_model;

/// The result object a Step creates
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPActivityResult extends RPResult {
  Map<String, dynamic> _results;

  //When ActivityResult only has a single value, pair that value with the following key
  /// The default key for the results map. It's used when there's only one answer result.
  /// In that case the result value is saved under this key in the map.
  @JsonKey(ignore: true)
  static const String DEFAULT_KEY = "answer";

  RPActivityResult();

  /// Returns an [RPActivityResult] with a given identifier and an empty map of results.
  ///
  /// It sets [startDate] to the ```DateTime.now()```. Since these objects are instantiated
  /// together with the Activity it belongs to so it can be used for measuring how much
  /// time the participant spent the given Activity.
  RPActivityResult.withParams(RPStep step)
      : super.withIdentifier(step.identifier) {
    this._results = Map();

    startDate = DateTime.now();
  }

  /// The map of results with a String as identifier and generic type as value
  Map<String, dynamic> get results => _results;

  set results(Map<String, dynamic> results) {
    this._results = results;
  }

  /// Returns result value for the given identifier from the [results] map
  dynamic getResultForIdentifier(String identifier) => _results[identifier];

  /// Adds a result to the result map with the given identifier.
  ///
  /// Used when the result is not a traditional answer result (e.g. signature result).
  /// Also used at Form Steps where there are multiple questions asked during a single step.
  void setResultForIdentifier(String identifier, dynamic result) {
    this._results[identifier] = result;
    this.endDate = DateTime.now();
  }

  /// Creates an entry for the [results] map with the default key.
  ///
  /// Usually it's used when there's only one result produced by the Question Body
  void setResult(dynamic result) {
    setResultForIdentifier(DEFAULT_KEY, result);
    this.endDate = DateTime.now();
  }

  factory RPActivityResult.fromJson(Map<String, dynamic> json) =>
      _$RPActivityResultFromJson(json);
  Map<String, dynamic> toJson() => _$RPActivityResultToJson(this);
}