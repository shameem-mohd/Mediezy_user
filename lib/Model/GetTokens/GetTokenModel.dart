class GetTokenModel {
  bool? status;
  TokenData? tokenData;

  GetTokenModel({this.status, this.tokenData});

  GetTokenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    tokenData = json['token_data'] != null
        ? TokenData.fromJson(json['token_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (tokenData != null) {
      data['token_data'] = tokenData!.toJson();
    }
    return data;
  }
}

class TokenData {
  List<MorningTokens>? morningTokens;
  List<EveningTokens>? eveningTokens;

  TokenData({this.morningTokens, this.eveningTokens});

  TokenData.fromJson(Map<String, dynamic> json) {
    if (json['morning_tokens'] != null) {
      morningTokens = <MorningTokens>[];
      json['morning_tokens'].forEach((v) {
        morningTokens!.add(MorningTokens.fromJson(v));
      });
    }
    if (json['evening_tokens'] != null) {
      eveningTokens = <EveningTokens>[];
      json['evening_tokens'].forEach((v) {
        eveningTokens!.add(EveningTokens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (morningTokens != null) {
      data['morning_tokens'] =
          morningTokens!.map((v) => v.toJson()).toList();
    }
    if (eveningTokens != null) {
      data['evening_tokens'] =
          eveningTokens!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MorningTokens {
  int? number;
  String? time;
  String? tokens;
  int? isBooked;
  int? isCancelled;
  int? isTimeout;
  String? formatedTime;

  MorningTokens(
      {this.number,
      this.time,
      this.tokens,
      this.isBooked,
      this.isCancelled,
      this.isTimeout,
      this.formatedTime});

  MorningTokens.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    time = json['Time'];
    tokens = json['Tokens'];
    isBooked = json['is_booked'];
    isCancelled = json['is_cancelled'];
    isTimeout = json['is_timeout'];
    formatedTime = json['FormatedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Number'] = number;
    data['Time'] = time;
    data['Tokens'] = tokens;
    data['is_booked'] = isBooked;
    data['is_cancelled'] = isCancelled;
    data['is_timeout'] = isTimeout;
    data['FormatedTime'] = formatedTime;
    return data;
  }
}

class EveningTokens {
  int? number;
  String? time;
  String? tokens;
  int? isBooked;
  int? isCancelled;
  int? isTimeout;
  String? formatedTime;

  EveningTokens(
      {this.number,
      this.time,
      this.tokens,
      this.isBooked,
      this.isCancelled,
      this.isTimeout,
      this.formatedTime});

  EveningTokens.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    time = json['Time'];
    tokens = json['Tokens'];
    isBooked = json['is_booked'];
    isCancelled = json['is_cancelled'];
    isTimeout = json['is_timeout'];
    formatedTime = json['FormatedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Number'] = number;
    data['Time'] = time;
    data['Tokens'] = tokens;
    data['is_booked'] = isBooked;
    data['is_cancelled'] = isCancelled;
    data['is_timeout'] = isTimeout;
    data['FormatedTime'] = formatedTime;
    return data;
  }
}
