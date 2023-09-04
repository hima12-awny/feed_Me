import 'package:final_training_project/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import 'RandomRecipes.dart';
import 'app_management/app_colors.dart';
import 'app_management/app_cubit.dart';
import 'app_management/app_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return DefaultTabController(
          initialIndex: 1,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.person_2_outlined)),
                  Tab(icon: Icon(UniconsLine.dice_six)),
                ],
              ),
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
            body: const TabBarView(
              children: [
                Profile(), // index 0
                RandomRecipe(), // index 1
              ],
            ),
          ),
        );
      },
    );
  }
}
