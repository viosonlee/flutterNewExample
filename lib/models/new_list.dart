class NewList {
  ResultSetBean ResultSet;

  NewList({this.ResultSet});

  NewList.fromJson(Map<String, dynamic> json) {
    this.ResultSet = json['ResultSet'] != null
        ? ResultSetBean.fromJson(json['ResultSet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ResultSet != null) {
      data['ResultSet'] = this.ResultSet.toJson();
    }
    return data;
  }
}

class ResultSetBean {
  String ExpireTime;
  List<ResultListBean> Result;

  ResultSetBean({this.ExpireTime, this.Result});

  ResultSetBean.fromJson(Map<String, dynamic> json) {
    this.ExpireTime = json['ExpireTime'];
    this.Result = (json['Result'] as List) != null
        ? (json['Result'] as List)
            .map((i) => ResultListBean.fromJson(i))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ExpireTime'] = this.ExpireTime;
    data['Result'] = this.Result != null
        ? this.Result.map((i) => i.toJson()).toList()
        : null;
    return data;
  }
}

class ResultListBean {
  String V1;
  String V2;
  String V3;

  ResultListBean({this.V1, this.V2, this.V3});

  ResultListBean.fromJson(Map<String, dynamic> json) {
    this.V1 = json['V1'];
    this.V2 = json['V2'];
    this.V3 = json['V3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['V1'] = this.V1;
    data['V2'] = this.V2;
    data['V3'] = this.V3;
    return data;
  }
}
