// class ProductModel {
//   late String id;
//   late String name;
//   late int code;
//   late int quantity;
//   late int unitPrice;
//   late int totalPrice;
//   late String imageUrl;
//
//   ProductModel.fromJson(Map<String, dynamic> productJson){
//     id = productJson['_id'];
//     name = productJson['ProductName'];
//     code = productJson['ProductCode'];
//     imageUrl = productJson['Img'];
//     quantity = productJson['Qty'];
//     unitPrice = productJson['UnitPrice'];
//     totalPrice = productJson['TotalPrice'];
//   }
// }


class Product {
  late String id;
  late String productName;
  late int productCode;
  late String img;
  late int qty;
  late int unitPrice;
  late int totalPrice;



  Product.fromJson(Map<String, dynamic> productJson){
    id = productJson['_id'];
    productName = productJson['ProductName'];
    productCode = productJson['ProductCode'];
    img = productJson['Img'];
    qty = productJson['Qty'];
    unitPrice = productJson['UnitPrice'];
    totalPrice = productJson['TotalPrice'];
  }
}
