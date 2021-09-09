import 'package:social_media/models/models.dart';

abstract class BaseUserRepository {
  Future<User> getUserWithId({String userId});
  Future<User> updateUser({User user});
}