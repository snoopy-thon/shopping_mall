import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopping_mall/constants.dart';
import 'package:shopping_mall/item_checkout_page.dart';
import 'package:shopping_mall/models/product.dart';

class ItemBasketPage extends StatefulWidget {
  const ItemBasketPage({super.key});

  @override
  State<ItemBasketPage> createState() => _ItemBasketPageState();
}

class _ItemBasketPageState extends State<ItemBasketPage> {
  List<Product> productList = [
    Product(
      productNo: 1,
      productName: "노트북(Laptop)",
      productImageUrl: "https://picsum.photos/id/1/300/300",
      price: 600000,
    ),
    Product(
      productNo: 2,
      productName: "스마트폰(Phone)",
      productImageUrl: "https://picsum.photos/id/20/300/300",
      price: 500000,
    ),
    Product(
      productNo: 3,
      productName: "머그컵(Cup)",
      productImageUrl: "https://picsum.photos/id/30/300/300",
      price: 15000,
    ),
    Product(
      productNo: 4,
      productName: "키보드(Keyboard)",
      productImageUrl: "https://picsum.photos/id/60/300/300",
      price: 50000,
    ),
    Product(
      productNo: 5,
      productName: "포도(Grape)",
      productImageUrl: "https://picsum.photos/id/75/200/300",
      price: 75000,
    ),
    Product(
      productNo: 6,
      productName: "책(book)",
      productImageUrl: "https://picsum.photos/id/24/200/300",
      price: 24000,
    ),
  ];

  double totalPrice = 0;
  Map<String, dynamic> cartMap = {};

  @override
  void initState() {
    super.initState();
    cartMap = json.decode(sharedPreferences.getString("cartMap") ?? "{}") ?? {};
  }

  double calculateTotalPrice() {
    totalPrice = 0;
    for (int i = 0; i < cartMap.length; i++) {
      totalPrice += productList
              .firstWhere((element) =>
                  element.productNo == int.parse(cartMap.keys.elementAt(i)))
              .price! *
          cartMap[cartMap.keys.elementAt(i)];
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("장바구니"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cartMap.length,
        itemBuilder: (context, index) {
          int productNo = int.parse(cartMap.keys.elementAt(index));
          Product currentProduct = productList
              .firstWhere((element) => element.productNo == productNo);
          return basketContainer(
              productNo: productNo,
              productName: currentProduct.productName ?? "",
              productImageUrl: currentProduct.productImageUrl ?? "",
              price: currentProduct.price ?? 0,
              quantity: cartMap[productNo.toString()]);
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: FilledButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const ItemCheckoutPage();
                },
              ),
            );
          },
          child: Text("총 ${numberFormat.format(calculateTotalPrice())}원 결제하기"),
        ),
      ),
    );
  }

  Widget basketContainer({
    required int productNo,
    required String productName,
    required String productImageUrl,
    required double price,
    required int quantity,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 130,
            fit: BoxFit.cover,
            imageUrl: productImageUrl,
            placeholder: (context, url) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            },
            errorWidget: (context, url, error) {
              return const Center(
                child: Text("오류 발생"),
              );
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${numberFormat.format(price)}원",
                ),
                Row(
                  children: [
                    const Text("수량: "),
                    IconButton(
                        onPressed: () {
                          if (cartMap[productNo.toString()] > 1) {
                            setState(() {
                              cartMap[productNo.toString()]--;

                              sharedPreferences.setString(
                                  "cartMap", json.encode(cartMap));
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.remove,
                        )),
                    Text(
                      "$quantity",
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          cartMap[productNo.toString()]++;

                          sharedPreferences.setString(
                              "cartMap", json.encode(cartMap));
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          cartMap.remove(productNo.toString());

                          sharedPreferences.setString(
                              "cartMap", json.encode(cartMap));
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                  ],
                ),
                Text(
                  "합계: ${numberFormat.format(price * quantity)}원",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
