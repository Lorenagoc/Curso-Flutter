import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/providers/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList productList = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_FORM,
              );
            },
            icon: const Icon(Icons.add_circle_rounded),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: productList.itemsCount,
              itemBuilder: (context, index) => Column(
                children: [
                  ProductItem(product: productList.items[index]),
                  const Divider(),
                ],
              ),
            )),
      ),
    );
  }
}
