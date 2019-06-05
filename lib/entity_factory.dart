import 'package:entry_exit_tour/entry_exit/entity/face_compare_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "FaceCompareEntity") {
      return FaceCompareEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}