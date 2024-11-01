import 'package:ethiosolar_app/app/core/exports/app_exports.dart';
import 'package:ethiosolar_app/app/modules/credit/creditScreen/controllers/credit_screen_controller.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/buttons/custom_elevated_button.dart';
import '../../../../routes/app_pages.dart';

class CreditDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final int index;
  final controller = Get.put(CreditScreenController());
  CreditDetailScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.v),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: Padding(
            padding: EdgeInsets.only(left: 24.adaptSize, top: 15.adaptSize),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 16.6.adaptSize,
              ),
              Text(
                "Cdredit Details",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          centerTitle: false,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text("A+ Credit Service (Personal)",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 15.adaptSize,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.visible,
                  ),
                ),
                SizedBox(
                  height: 20.adaptSize,
                ),
                CustomElevatedButton(
                  text: "Apply",
                  margin:
                      EdgeInsets.only(left: 10.h, right: 10.h, bottom: 42.v),
                  buttonTextStyle: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                  height: 45.v,
                  child: controller.isApplyingCreditLoading.isTrue
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : null,
                  onPressed: () {
                    Get.toNamed(
                      Routes.creditFormView,
                      arguments: controller.creditList[index].id.toString(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
