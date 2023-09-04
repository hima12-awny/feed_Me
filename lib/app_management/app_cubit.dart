import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  late Database database;

  var email = TextEditingController();
  var name = TextEditingController();
  var password = TextEditingController();
  var conformPassword = TextEditingController();

  var phone = TextEditingController();
  var weight = TextEditingController();
  var height = TextEditingController();
  var age = TextEditingController();
  var mbi = TextEditingController();

  var scrollCon = ScrollController();

  var searchItems = TextEditingController();

  Map<String, User> users = {};
  var recipes = [];
  var fillterdRecipes = [];

  var recipe = {};
  var prevRecipe = {};
  Map mbiResults = {};

  bool isUserFound = false;
  bool isUserValid = false;
  bool isSignUpOpened = false;

  Future<SharedPreferences> sharePrefObj = SharedPreferences.getInstance();

  void getPrevRecipe() {
    recipe = prevRecipe;
    prevRecipe = {};
    scrollCon.animateTo(scrollCon.position.minScrollExtent,
        duration: const Duration(milliseconds: 2500), curve: Curves.bounceOut);
    emit(GetPrevRecipeState());
  }

  void filterRecipes() async {
    Set temp = {};

    if (searchItems.text.isEmpty) {
      temp = recipes.toSet();
    } else {
      var items = searchItems.text.split('-');
      for (var item in items) {
        for (var rcp in recipes) {
          for (var ingred in rcp['ingredients']) {
            if (ingred.contains(item)) {
              temp.add(rcp);
            }
          }
        }
      }
    }
    fillterdRecipes = temp.toList();
    randomRecipe(fillterdRecipes);
  }

  void randomRecipe(var recipes) {
    var index = Random().nextInt(recipes.length);

    if (recipe.isNotEmpty) {
      prevRecipe = recipe;
    }

    recipe = recipes[index];
    scrollCon.animateTo(scrollCon.position.minScrollExtent,
        duration: const Duration(milliseconds: 2500), curve: Curves.bounceOut);

    emit(RandomRecipeState());
  }

  Future<void> getSharedPrefData() async {
    SharedPreferences pref = await sharePrefObj;
    String? prefEmail = pref.getString('emailPref');

    if (prefEmail != null) {
      email.text = prefEmail;
    }
    emit(SetGetSharedPref());
  }

  Future<void> setPrefEmail() async {
    SharedPreferences pref = await sharePrefObj;
    pref.setString('emailPref', email.text);
    emit(SetGetSharedPref());
  }

  Future<void> resetSharePref() async {
    SharedPreferences pref = await sharePrefObj;
    pref.remove('emailPref');

    email.clear();
    password.clear();

    emit(SetGetSharedPref());
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('dataFiles/recipes.json');
    recipes = await json.decode(response);
  }

  void putPersonalData() {
    name.text = users[email.text]!.name;
    phone.text = users[email.text]!.phone;
    age.text = users[email.text]!.age.toString();
    weight.text = users[email.text]!.weight.toString();
    height.text = users[email.text]!.height.toString();
    calculateMBI();
    mbi.text = mbiResults['num'] + ' : ' + mbiResults['str'];
    emit(SetDataInInputsInProfile());
  }

  void clearAllTextInput() {
    email.clear();
    name.clear();
    password.clear();
    conformPassword.clear();
    phone.clear();
    age.clear();
    weight.clear();
    height.clear();
    isSignUpOpened = true;
    emit(ClearAllTextState());
  }

  void userFoundAndCheckPassword() {
    isUserFound = users[email.text] != null;
    isUserValid =
        isUserFound ? users[email.text]?.password == password.text : false;
    emit(IsUserFoundState());
  }

  void createDatabase() async {
    openDatabase('feedme.db', version: 1, onCreate: (db, version) {
      print('Database Created');

      db
          .execute(
              'CREATE TABLE User (email TEXT PRIMARY KEY,name TEXT, password TEXT, phone TEXT, weight INTEGER, height INTEGER, age INTEGER)')
          .then((value) {
        print('Table Created');
      }).catchError((onError) {
        print(onError.toString());
      });
    }, onOpen: (db) {
      print('Database opened');
    }).then((value) async {
      database = value;
      getUserDataFromDatabase(database);

      await getSharedPrefData();
      await readJson();
      randomRecipe(recipes);
    });
  }

  void insertUser() async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              "INSERT INTO User (email,name,password,phone,weight,height,age) VALUES ('${email.text}', '${name.text}', '${password.text}','${phone.text}', ${weight.text},${weight.text}, ${age.text})")
          .then((value) {
        users[email.text] = User(
            email.text,
            name.text,
            password.text,
            phone.text,
            int.parse(weight.text),
            int.parse(height.text),
            int.parse(age.text));

        print('${email.text} inserted done.');
        print(users);
        isSignUpOpened = false;
        emit(InsertUserState());
      }).catchError((onError) {
        print('ERROR');
        print(onError.toString());
      });
    });
  }

  void getUserDataFromDatabase(Database database) async {
    List<Map> tempUsers = [];
    await database.rawQuery('SELECT * FROM User').then((value) {
      tempUsers = value;
    });

    for (var user in tempUsers) {
      users[user['email']] = User(user['email'], user['name'], user['password'],
          user['phone'], user['weight'], user['height'], user['age']);
    }
    print(users);
    emit(GetDataFromDatabaseState());
  }

  void calculateMBI() {
    double resultNum =
        double.parse(weight.text) / pow((double.parse(height.text) / 100), 2);
    String? resultStr;

    if (resultNum < 18.5) {
      resultStr = "Underweight";
    } else if (resultNum >= 18.5 && resultNum <= 24.9) {
      resultStr = "Normal Weight";
    } else if (resultNum >= 25 && resultNum <= 29.9) {
      resultStr = "Overweight";
    } else if (resultNum >= 30) {
      resultStr = "Obesity";
    }

    mbiResults["num"] = resultNum.toStringAsFixed(1);
    mbiResults["str"] = resultStr;

    emit(CalculateMBIState());
  }
}

class User {
  String email;
  String name;
  String password;
  String phone;
  int weight;
  int height;
  int age;

  User(this.email, this.name, this.password, this.phone, this.weight,
      this.height, this.age);
}
