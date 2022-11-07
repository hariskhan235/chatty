import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable{
  final String email;
  final String name;
  String uid;
  String? image;

  /// [type] shall never be null
 // final UserType? type;

  UserModel({
    //required this.type,
    required this.email,
    required this.name,
    this.image,
    required this.uid,
  });
   //: assert(type != null, "Type should never be null");

  factory UserModel.fromJson(Map<String, dynamic> json,
          {required String uid}) =>
      UserModel(
        uid: json["uid"] ?? uid,
        email: json['email'],
        name: json['name'],
        // type: json['type'] == "buyer"
        //     ? UserType.buyer
        //     : json['type'] == null
        //         ? null
        //         : UserType.seller,
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        //"type": type == UserType.buyer ? "buyer" : "seller",
        "image": image,
      };
      
        @override
        // TODO: implement props
        List<Object?> get props => [email,name,image];
}

//enum UserType { seller, buyer }