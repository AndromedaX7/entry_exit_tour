class FaceCompareEntity {
	String msg;
	FaceCompareObj obj;
	bool success;
	dynamic attributes;

	FaceCompareEntity({this.msg, this.obj, this.success, this.attributes});

	FaceCompareEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		obj = json['obj'] != null ? new FaceCompareObj.fromJson(json['obj']) : null;
		success = json['success'];
		attributes = json['attributes'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		if (this.obj != null) {
      data['obj'] = this.obj.toJson();
    }
		data['success'] = this.success;
		data['attributes'] = this.attributes;
		return data;
	}
}

class FaceCompareObj {
	String msg;
	FaceCompareObjData data;
	int status;

	FaceCompareObj({this.msg, this.data, this.status});

	FaceCompareObj.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		data = json['data'] != null ? new FaceCompareObjData.fromJson(json['data']) : null;
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['status'] = this.status;
		return data;
	}
}

class FaceCompareObjData {
	double sim;
	String errormsg;
	int libTime;
	int errorcode;
	String token;

	FaceCompareObjData({this.sim, this.errormsg, this.libTime, this.errorcode, this.token});

	FaceCompareObjData.fromJson(Map<String, dynamic> json) {
		sim = (json['sim'] *1.0);
		errormsg = json['errormsg'];
		libTime = json['lib_time'];
		errorcode = json['errorcode'];
		token = json['token'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['sim'] = this.sim;
		data['errormsg'] = this.errormsg;
		data['lib_time'] = this.libTime;
		data['errorcode'] = this.errorcode;
		data['token'] = this.token;
		return data;
	}
}
