import 'package:coursecupid/api_lib/swagger.swagger.dart';
import 'package:coursecupid/core/resp_ext.dart';

abstract class Filterer<T> {
  List<T> search(List<T> list, String t);
}

class TwoWaySuggestionFilterer extends Filterer<TwoWaySuggestionResp> {
  @override
  List<TwoWaySuggestionResp> search(List<TwoWaySuggestionResp> list, String t) {
    return list
        .where((element) =>
            t.lowerCompare(element.module) ||
            t.lowerCompare(element.post1?.index?.code) ||
            t.lowerCompare(element.post2?.index?.code))
        .toList();
  }
}

class ThreeWaySuggestionFilterer extends Filterer<ThreeWaySuggestionResp> {
  @override
  List<ThreeWaySuggestionResp> search(
      List<ThreeWaySuggestionResp> list, String t) {
    return list
        .where((element) =>
            t.lowerCompare(element.module) ||
            t.lowerCompare(element.post1?.index?.code) ||
            t.lowerCompare(element.post2?.index?.code))
        .toList();
  }
}
