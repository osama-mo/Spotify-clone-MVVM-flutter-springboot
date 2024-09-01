import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'current_searchterm_notifier.g.dart';


@Riverpod(keepAlive: true)
class CurrentSearchTermNotifier extends _$CurrentSearchTermNotifier {
  @override
  String? build() {
    return null;
  }

  void setTerm(String term) {
    state = term;
  }

}