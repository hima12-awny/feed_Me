import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_management/app_colors.dart';
import 'app_management/app_cubit.dart';
import 'app_management/app_state.dart';

class RandomRecipe extends StatelessWidget {
  const RandomRecipe({
    super.key,
  });

  List<Widget> getBolitPoints(var items) {
    List<Widget> texts = [];

    for (var item in items) {
      texts.add(Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Expanded(
            child: Text("# $item",
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontSize: 15, color: Colors.black)),
          ),
        ),
      ));
    }

    return texts;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          backgroundColor: mainBackgroundColor,
          body: SingleChildScrollView(
            controller: cubit.scrollCon,
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 15, left: 10, right: 10),
              child: Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              image: NetworkImage(cubit.recipe['image']),
                              fit: BoxFit.fill),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.black45,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  cubit.recipe['name'],
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                      fontSize: 40, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 200),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white38,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, right: 15),
                                child: Text("المقادير",
                                    style: TextStyle(
                                        fontSize: 27, color: Colors.black)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children:
                                    getBolitPoints(cubit.recipe['ingredients']),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white38,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, right: 15),
                                child: Text("الخطوات",
                                    style: TextStyle(
                                        fontSize: 27, color: Colors.black)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                children:
                                    getBolitPoints(cubit.recipe['directions']),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 8, right: 8, left: 8),
                      child: Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: mainBackgroundColor,
                                      disabledBackgroundColor:
                                          const Color(0x86aef1d1),
                                      foregroundColor: Colors.black87),
                                  onPressed: cubit.prevRecipe.isNotEmpty
                                      ? () {
                                          cubit.getPrevRecipe();
                                        }
                                      : null,
                                  child: const Text("الوصفة السابقة"))),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: mainBackgroundColor,
                                foregroundColor: Colors.black87),
                            child: const Text("وصفة جديدة"),
                            onPressed: () {
                              cubit.filterRecipes();
                            },
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: TextFormField(
                        textDirection: TextDirection.rtl,
                        controller: cubit.searchItems,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: appBarColor)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0)),
                          filled: true,
                          fillColor: mainBackgroundColor,
                          labelText: "المقادير المتاحة",
                          hintText: 'فول-عدس',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
