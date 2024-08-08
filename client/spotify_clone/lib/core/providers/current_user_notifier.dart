import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/auth/model/User.dart';

part 'current_user_notifier.g.dart';


@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  User? build() {
    return null;
  }

  void setUser(User user) {
    state = user;
  }

}