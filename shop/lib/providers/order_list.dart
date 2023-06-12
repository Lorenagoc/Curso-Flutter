import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/cart_item.dart';
import 'order.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class OrderList with ChangeNotifier {
  final String _token;
  final String _userId;
  List<Order> _items = [];

  OrderList([
    this._token = '',
    this._userId = '',
    this._items = const [],
  ]);

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    List<Order> items = [];

    // final response = await http.get(
    //   Uri.parse('${Constants.ORDER_BASE_URL}.json?auth=$_token'),
    // );
    // if (response.body == 'null') return;

    final ordersResponse = await http.get(
      Uri.parse('${Constants.USER_ORDERS_URL}/$_userId.json?auth=$_token'),
    );

    if (ordersResponse.body == 'null') return;

    Map<String, dynamic> dataOrders = jsonDecode(ordersResponse.body);

    dataOrders.forEach((orderId, orderData) {
      items.add(
        Order(
          id: orderId,
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartItem(
              item['id'],
              item['productId'],
              item['name'],
              item['quantity'],
              item['price'],
            );
          }).toList(),
          date: DateTime.parse(orderData['date']),
        ),
      );
    });

    _items = items.reversed.toList(); // Pedidos mais novos primeiro
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.USER_ORDERS_URL}/$_userId.json?auth=$_token'),
      body: jsonEncode(
        {
          "total": cart.totalAmount,
          "date": date.toIso8601String(),
          "products": cart.items.values
              .map(
                (cartItem) => {
                  "id": cartItem.id,
                  "productId": cartItem.productId,
                  "name": cartItem.name,
                  "quantity": cartItem.quantity,
                  "price": cartItem.price,
                },
              )
              .toList(),
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];

    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        date: date,
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}
