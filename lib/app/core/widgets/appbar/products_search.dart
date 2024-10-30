import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/data/models/product/product_model.dart';
import 'package:ethiosolar_app/app/modules/shopScreen/controllers/shop_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../modules/cartScreen/controllers/cart_screen_controller.dart';
import '../../../modules/shopScreen/widgets/all_product_card.dart';
import '../../../modules/shopScreen/widgets/productcardlist_item_widget.dart';
import '../../../routes/app_pages.dart';
import '../../utils/utils.dart';

class ProductSearch extends SearchDelegate<ProductModel?> {
  ProductSearch({required this.controller}) : super();
  final ShopScreenController controller;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.adaptive.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return FutureBuilder(
      future: query == "" || query.length < 3
          ? null
          : controller.searchProduct(searchTerm: query),
      builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) =>
          query == ''
              ? Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '${searchProduct.tr}...',
                    style: theme.bodyMedium,
                  ),
                )
              : snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : snapshot.hasData && snapshot.data != null
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                            itemBuilder: (context, index) => AllcardItemWidget(
                              product: controller.productList[index],
                            ),
                            itemCount: snapshot.data!.length,
                          ),
                        )
                      : Center(
                          child: Text(
                            "No Data Found",
                            style: theme.labelLarge,
                          ),
                        ),
    );
  }
}
