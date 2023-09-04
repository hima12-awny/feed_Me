import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_management/app_colors.dart';
import 'app_management/app_cubit.dart';
import 'app_management/app_state.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        cubit.putPersonalData();

        return Scaffold(
          backgroundColor: mainBackgroundColor,
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 15, left: 10, right: 10),
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
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      const Row(
                        children: [
                          Text(
                            "Profile",
                            style: TextStyle(fontSize: 40, shadows: [
                              Shadow(
                                  offset: Offset.zero,
                                  blurRadius: 20,
                                  color: Colors.white)
                            ]),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // email
                      TextFormField(
                        controller: cubit.email,
                        enabled: false,
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // name
                      TextFormField(
                        enabled: false,
                        controller: cubit.name,
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
                            labelText: "Name",
                            labelStyle: const TextStyle(color: Colors.black),
                            prefixIcon:
                                const Icon(Icons.supervised_user_circle),
                            prefixIconColor: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // password
                      TextFormField(
                        controller: cubit.password,
                        enabled: false,
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
                            labelStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(Icons.password_outlined),
                            prefixIconColor: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // phone
                      TextFormField(
                        controller: cubit.phone,
                        enabled: false,
                        keyboardType: TextInputType.number,
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
                            labelText: "Phone",
                            labelStyle: const TextStyle(color: Colors.black),
                            prefixIcon:
                                const Icon(Icons.phone_enabled_outlined),
                            prefixIconColor: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Expanded(
                                child: TextFormField(
                              enabled: false,
                              controller: cubit.age,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: appBarColor)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2.0)),
                                  filled: true,
                                  fillColor: mainBackgroundColor,
                                  labelText: "Age",
                                  labelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  prefixIcon: const Icon(Icons.hub_outlined),
                                  prefixIconColor: Colors.black),
                            )),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              controller: cubit.weight,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: appBarColor)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2.0)),
                                  filled: true,
                                  fillColor: mainBackgroundColor,
                                  labelText: "Weight",
                                  labelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  prefixIcon: Image.asset('icons/weight.png')),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              controller: cubit.height,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: appBarColor)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2.0)),
                                  filled: true,
                                  fillColor: mainBackgroundColor,
                                  labelText: "Height",
                                  labelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 13),
                                  prefixIcon: Image.asset('icons/height.png')),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // mbi
                      TextFormField(
                        enabled: false,
                        controller: cubit.mbi,
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
                            labelText: "MBI",
                            labelStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(Icons.boy_outlined),
                            prefixIconColor: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          const Spacer(),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainBackgroundColor,
                                  foregroundColor: Colors.black),
                              onPressed: () {
                                cubit.resetSharePref();
                                Navigator.pop(context);
                              },
                              child: const Text("Logout"))
                        ],
                      )
                    ],
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
