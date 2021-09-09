import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String profileImageURL;
  final int followers;
  final int following;
  final String bio;

  const User({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.profileImageURL,
    @required this.followers,
    @required this.following,
    @required this.bio,
  });

  static const empty = User(
    id: "", 
    username: "", 
    email: "", 
    profileImageURL: "", 
    followers: 0, 
    following: 0, 
    bio: ""
  );

  @override
  List<Object> get props => [
    id,
    username,
    email,
    profileImageURL,
    followers,
    following,
    bio,
  ];

  User copyWith({
    String id,
    String username,
    String email,
    String profileImageURL,
    int followers,
    int following,
    String bio,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImageURL: profileImageURL ?? this.profileImageURL,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "username": username,
      "email": email,
      "profileImageURL": profileImageURL,
      "followers": followers,
      "following": following,
      "bio": bio,
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    if (doc == null) return null;
    final data = doc.data();
    return User(
      id: doc.id,
      username: data["username"] ?? "",
      email: data["email"] ?? "",
      profileImageURL: data["profileImageURL"] ?? "",
      followers: (data["followers"] ?? 0).toInt(),
      following: (data["following"] ?? 0).toInt(),
      bio: data["bio"] ?? "",

    );
  }
}
