import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

import '../model/useraddquizmodel.dart';
import '../utils/constant.dart';

//connect_to_mongoDatabase


class MongoDatabase{
  static var db, userCollection;

  static  connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static insert(UserQuiz user) async {
    await userCollection.insertAll([user.toMap()]);
  }
  //To Read
  static Future<List<Map<String, dynamic>>> getDocuments() async {
    try {
      final users = await userCollection.find().toList();
      return users;
    } catch (e) {
      print(e);
      return Future.value(Future.error(e));
    }
  }
  // Update
  static update(UserQuiz user) async {
    var u = await userCollection.findOne({"_id": user.id});
    u["name"] = user.userCategory;
    u["age"] = user.userCorrectAnswer;
    u["phone"] = user.userIncorrectAnswers;
    await userCollection.save(u);
  }
// Delete
  static delete(UserQuiz user) async {
    await userCollection.remove(where.id(user.id));
  }

}