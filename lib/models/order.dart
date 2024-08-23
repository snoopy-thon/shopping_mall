// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductOrder {
  String? orderNo;
  int? productNo;
  String? orderDate;
  String? buyerName;
  String? buyerEmail;
  String? buyerPhone;
  String? receiverName;
  String? receiverPhone;
  String? receiverZip;
  String? receiverAddress1;
  String? receiverAddress2;
  String? userPwd;
  String? paymentMethod;
  int? quantity;
  double? unitPrice;
  double? totalPrice;
  String? paymentStatus;
  String? deliveryStatus;

  ProductOrder({
    this.orderNo,
    this.productNo,
    this.orderDate,
    this.buyerName,
    this.buyerEmail,
    this.buyerPhone,
    this.receiverName,
    this.receiverPhone,
    this.receiverZip,
    this.receiverAddress1,
    this.receiverAddress2,
    this.userPwd,
    this.paymentMethod,
    this.quantity,
    this.totalPrice,
    this.paymentStatus,
    this.deliveryStatus,
    this.unitPrice,
  });

  ProductOrder.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderId'];
    productNo = json['productNo'];
    orderDate = json['orderDate'];
    buyerName = json['buyerName'];
    buyerEmail = json['buyerEmail'];
    buyerPhone = json['buyerPhone'];
    receiverName = json['receiverName'];
    receiverPhone = json['receiverPhone'];
    receiverZip = json['receiverZip'];
    receiverAddress1 = json['receiverAddress1'];
    receiverAddress2 = json['receiverAddress2'];
    userPwd = json['userPwd'];
    unitPrice = json['unitPrice'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
    paymentStatus = json['paymentStatus'];
    paymentMethod = json['paymentMethod'];
    deliveryStatus = json['deliveryStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['productNo'] = productNo;
    data['orderDate'] = orderDate;
    data['orderNo'] = orderNo;
    data['buyerName'] = buyerName;
    data['buyerEmail'] = buyerEmail;
    data['buyerPhone'] = buyerPhone;
    data['receiverName'] = receiverName;
    data['receiverPhone'] = receiverPhone;
    data['receiverZip'] = receiverZip;
    data['receiverAddress1'] = receiverAddress1;
    data['receiverAddress2'] = receiverAddress2;
    data['userPwd'] = userPwd;
    data['paymentMethod'] = paymentMethod;
    data['unitPrice'] = unitPrice;
    data['quantity'] = quantity;
    data['totalPrice'] = totalPrice;
    data['paymentStatus'] = paymentStatus;
    data['deliveryStatus'] = deliveryStatus;
    return data;
  }
}
