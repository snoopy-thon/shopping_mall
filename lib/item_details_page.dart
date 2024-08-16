import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_mall/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopping_mall/constants.dart';
import 'package:shopping_mall/item_basket_page.dart';

class ItemDetailPage extends StatefulWidget {
  int productNo;
  String productName;
  String productImageUrl;
  double price;

  ItemDetailPage({
    super.key,
    required this.productNo,
    required this.productName,
    required this.productImageUrl,
    required this.price,
  });

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('제품 상세 페이지'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            productImageContainer(),
            productNameContainer(),
            productPriceContainer(),
            productQuantityContainer(),
            productTotalPriceContainer(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: FilledButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const ItemBasketPage();
                },
              ),
            );
          },
          child: const Text("장바구니 담기"),
        ),
      ),
    );
  }

  Widget productPriceContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        "${numberFormat.format(widget.price)}원",
      ),
    );
  }

  Widget productNameContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        widget.productName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget productImageContainer() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: CachedNetworkImage(
        width: MediaQuery.of(context).size.width * 0.8,
        imageUrl: widget.productImageUrl,
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
    );
  }

  Widget productQuantityContainer() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("수량: "),
          IconButton(
            onPressed: substractProduct,
            icon: const Icon(Icons.remove),
          ),
          Text("$quantity"),
          IconButton(
            onPressed: addProduct,
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
    );
  }

  Widget productTotalPriceContainer() {
    return Container(
      child: Text(
        "총 상품금액: ${numberFormat.format(widget.price * quantity)}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void substractProduct() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  void addProduct() {
    setState(() {
      quantity++;
    });
  }
}
