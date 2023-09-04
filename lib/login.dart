import 'package:final_training_project/HomeScreen.dart';
import 'package:final_training_project/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_management/app_colors.dart';
import 'app_management/app_cubit.dart';
import 'app_management/app_state.dart';

class Login extends StatelessWidget {
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            backgroundColor: appBarColor,
            foregroundColor: Colors.black,
            title: Row(
              children: [
                Image.asset('icons/header.png'),
                const SizedBox(
                  width: 10,
                ),
                const Text("Feed Me"),
              ],
            ),
          ),
          backgroundColor: mainBackgroundColor,
          body: Center(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  constraints: const BoxConstraints(
                      minHeight: 200, minWidth: double.infinity),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(2, 2), // changes position of shadow
                        ),
                      ],
                      color: appBarColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Text(
                            "Login",
                            style: TextStyle(fontSize: 40, shadows: [
                              Shadow(
                                  offset: Offset.zero,
                                  blurRadius: 20,
                                  color: Colors.white)
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // email
                          TextFormField(
                            controller: cubit.email,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    borderSide: BorderSide(color: appBarColor)),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0)),
                                filled: true,
                                fillColor: mainBackgroundColor,
                                labelText: "Email",
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                prefixIcon: const Icon(Icons.email_outlined),
                                prefixIconColor: Colors.black),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Required';
                              } else {
                                cubit.userFoundAndCheckPassword();
                                if (!cubit.isUserFound) {
                                  return 'User Not Found';
                                }
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // password
                          TextFormField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: cubit.password,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    borderSide: BorderSide(color: appBarColor)),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0)),
                                filled: true,
                                fillColor: mainBackgroundColor,
                                labelText: "Password",
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                prefixIcon: const Icon(Icons.password_outlined),
                                prefixIconColor: Colors.black),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Required';
                              }
                              cubit.userFoundAndCheckPassword();
                              if (cubit.isUserFound && !cubit.isUserValid) {
                                return 'Incorrect Password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                cubit.setPrefEmail();
                                if (formKey.currentState!.validate()) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomeScreen()));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainBackgroundColor,
                                  side:
                                      BorderSide(width: 1, color: appBarColor),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  shadowColor: Colors.white),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't Have Account?"),
                              GestureDetector(
                                onTap: () {
                                  cubit.clearAllTextInput();

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SignUp()));
                                },
                                child: const Text(
                                  "  Sign Up",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
