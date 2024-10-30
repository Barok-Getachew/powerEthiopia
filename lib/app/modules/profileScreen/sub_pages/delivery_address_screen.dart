import 'package:ethiosolar_app/app/core/extensions/validators.dart';
import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar/custom_app_bar.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar/appbar_leading_image.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar/appbar_title.dart';
import 'package:ethiosolar_app/app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:ethiosolar_app/app/core/widgets/input_fields/custom_text_form_field.dart';
import 'package:ethiosolar_app/app/data/models/address/delivery_address_model.dart';
import 'package:ethiosolar_app/app/data/models/city/city_model.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/controllers/delivery_address_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class DeliveryAddressScreen extends GetView<DeliveryAddressController> {
  const DeliveryAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 7,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Obx(() => controller.isLoadingAddress.isTrue
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.width * 0.5,
                        child: ListView.separated(
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                            width: 30,
                          ),
                          itemBuilder: (context, index) =>
                              _buildDeliveryAddressFrame(
                            context,
                            controller.deliveryAddress[index],
                          ),
                          itemCount: controller.deliveryAddress.length,
                        ),
                      )),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 18),
                Text(
                  addNewAddress.tr,
                  style: theme.bodyMedium!.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 11),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(deliveryAddress.tr,
                        style: theme.bodyMedium!
                            .copyWith(color: Colors.grey[600])),
                  ),
                ),
                const SizedBox(height: 8),
                _buildAddressEditText(context),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(city.tr,
                        style: theme.bodyMedium!
                            .copyWith(color: Colors.grey[600])),
                  ),
                ),
                const SizedBox(height: 8),
                // _buildCityEditText(context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TypeAheadField<CityModel>(
                    loadingBuilder: (BuildContext context) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      );
                    },
                    controller: controller.cityController,
                    suggestionsCallback: (search) {
                      return controller.cities.where((product) {
                        final nameLower =
                            product.name?.toLowerCase().split(' ').join('') ??
                                '';
                        final patternLower =
                            search.toLowerCase().split(' ').join('');
                        return nameLower.contains(patternLower);
                      }).toList();
                    }, //CityService.of(context).find(search),
                    builder: (context, controller, focusNode) {
                      return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          autofocus: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color:
                                      Color(0xFFE2E1E5) //Colors.grey.shade100,
                                  ),
                            ),
                            // labelText: 'City',
                          ));
                    },
                    itemBuilder: (context, city) {
                      return ListTile(
                        title: Text(city.name!),
                        // subtitle: Text(city.country),
                      );
                    },
                    onSelected: (city) {
                      controller.cityController.text = city.name.toString();
                      controller.selectedCity.value = city.name.toString();
                      debugPrint("selected ${controller.selectedCity.value}");
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(contactPersonName.tr,
                        style: theme.bodyMedium!
                            .copyWith(color: Colors.grey[600])),
                  ),
                ),
                const SizedBox(height: 9),
                _buildNameEditText(context),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(contactPhoneNumber.tr,
                        style: theme.bodyMedium!
                            .copyWith(color: Colors.grey[600])),
                  ),
                ),
                const SizedBox(height: 9),
                _buildPhoneNumberEditText(context),
                const SizedBox(height: 15),
                _buildAddAddressButton(context),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 64,
      leading: AppbarLeadingImage(
        imagePath: 'assets/images/img_arrow_down.svg',
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: addDeliveryAddress.tr,
      ),
    );
  }

  /// Section Widget
  Widget _buildRemoveAddressButton(
      BuildContext context, int deliveryAddressId) {
    return Obx(
      () => CustomElevatedButton(
        height: 35,
        // width: 138,
        text: removeAddress.tr,
        buttonStyle:
            const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
        child: controller.isRemovingLoadingAddress.isTrue
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : null,
        onPressed: () => controller.removeAddress(deliveryAddressId),
      ),
    );
  }

  /// Section Widget
  Widget _buildDeliveryAddressFrame(
      BuildContext context, DeliveryAddressModel deliveryAddress) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(
        horizontal: 19,
        vertical: 9,
      ),
      decoration: AppDecoration.outlineGray600.copyWith(
        color: Colors.white,
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAddressFrame(
            context,
            label: contactPersonName.tr,
            value: deliveryAddress.contactName ?? "",
          ),
          _buildAddressFrame(
            context,
            label: contactPhoneNumber.tr,
            value: deliveryAddress.phoneNumber ?? "",
          ),
          _buildAddressFrame(
            context,
            label: address.tr,
            value: deliveryAddress.address ?? "",
          ),
          _buildAddressFrame(
            context,
            label: city.tr,
            value: deliveryAddress.city ?? "",
          ),
          const SizedBox(height: 10),
          _buildRemoveAddressButton(
            context,
            deliveryAddress.id ?? -1,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAddressEditText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextFormField(
        controller: controller.addressEditTextController,
        validator: (value) => value.toString().validateField(
              fieldName: deliveryAddress.tr,
            ),
      ),
    );
  }

  /// Section Widget
  Widget _buildCityEditText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextFormField(
        controller: controller.cityEditTextController,
        validator: (value) =>
            value.toString().validateField(fieldName: city.tr),
      ),
    );
  }

  /// Section Widget
  Widget _buildNameEditText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextFormField(
        controller: controller.nameEditTextController,
        validator: (value) =>
            value.toString().validateField(fieldName: "Contact Person Name"),
      ),
    );
  }

  /// Section Widget
  Widget _buildPhoneNumberEditText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextFormField(
        controller: controller.phoneNumberEditTextController,
        textInputAction: TextInputAction.done,
        validator: (value) => value
            .toString()
            .validateField(fieldName: "Contact Person PhoneNumber"),
      ),
    );
  }

  /// Section Widget
  Widget _buildAddAddressButton(BuildContext context) {
    return Obx(
      () => CustomElevatedButton(
        height: 55,
        width: 250,
        text: addAddress.tr,
        buttonStyle: const ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.zero),
          textStyle: WidgetStatePropertyAll(
              TextStyle(color: Colors.white, fontSize: 22)),
        ),
        onPressed: () => controller.addDeliveryAddress(),
        child: controller.isAddLoadingAddress.isTrue
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }

  /// Common widget
  Widget _buildAddressFrame(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF222222),
              ),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF222222), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
