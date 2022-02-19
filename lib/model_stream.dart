class ClassStream {
  String? streamUuId;
  String streamNome;
  DateTime? streamData;

  ClassStream({
    this.streamUuId,
    required this.streamNome,
    this.streamData,
  });

  factory ClassStream.fromJson(Map<String, dynamic> map) {
    return ClassStream(
      streamUuId: map['streamUuId'.toString()],
      streamNome: map['streamNome'.toString()],
    );
  }

  Map<String, dynamic> toJson() => {
        'streamNome': streamNome,
      };
}
