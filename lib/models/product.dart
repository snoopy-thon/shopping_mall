// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Product {
  int? productNo;
  String? productName;
  String? productDetails;
  String? productImageUrl;
  double? price;

  Product({
    this.productNo,
    this.productName,
    this.productDetails,
    this.productImageUrl,
    this.price,
  });

  // named constructor - dart에서는 "생성자에 이름을 붙여서" 여러개의 생성자를 정의할 수 있음.
  Product.fromJson(Map<String, dynamic> json) {
    productNo = int.parse(json['productNo']);
    productName = json['productName'];
    productDetails = json['productDetails'];
    productImageUrl = json['productImageUrl'];
    price = double.parse(json['price']);
  }

  // Product 객체의 멤버값을 json으로 변환하는 함수 정의
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['productNo'] = productNo;
    data['productName'] = productName;
    data['productDetails'] = productDetails;
    data['productImageUrl'] = productImageUrl;
    data['price'] = price;
    return data;
  }
}
