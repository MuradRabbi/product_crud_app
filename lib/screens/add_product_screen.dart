import 'package:api_crud_project/api_services.dart';
import 'package:api_crud_project/model_class/product_model.dart';
import 'package:flutter/material.dart';

class AddEditProductScreen extends StatefulWidget {
  final Product? product;
  AddEditProductScreen({this.product});

  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameCtrl;
  late TextEditingController codeCtrl;
  late TextEditingController imgCtrl;
  late TextEditingController qtyCtrl;
  late TextEditingController unitPriceCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.product?.productName ?? "");
    codeCtrl = TextEditingController(text: widget.product?.productCode.toString() ?? "");
    imgCtrl = TextEditingController(text: widget.product?.img ?? "");
    qtyCtrl = TextEditingController(text: widget.product?.qty.toString() ?? "");
    unitPriceCtrl = TextEditingController(text: widget.product?.unitPrice.toString() ?? "");
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final productData = {
        "ProductName": nameCtrl.text,
        "ProductCode": int.parse(codeCtrl.text),
        "Img": imgCtrl.text,
        "Qty": int.parse(qtyCtrl.text),
        "UnitPrice": int.parse(unitPriceCtrl.text),
        "TotalPrice": int.parse(qtyCtrl.text) * int.parse(unitPriceCtrl.text),
      };

      if (widget.product == null) {
        await ApiService.createProduct(productData);
      } else {
        await ApiService.updateProduct(widget.product!.id, productData);
      }

      Navigator.pop(context);
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType type = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (val) => val == null || val.isEmpty ? "$label required" : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product == null ? "Add Product" : "Edit Product")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Product Name", nameCtrl),
              SizedBox(height: 12),
              _buildTextField("Product Code", codeCtrl, type: TextInputType.number),
              SizedBox(height: 12),
              _buildTextField("Image URL", imgCtrl),
              SizedBox(height: 12),
              _buildTextField("Quantity", qtyCtrl, type: TextInputType.number),
              SizedBox(height: 12),
              _buildTextField("Unit Price", unitPriceCtrl, type: TextInputType.number),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                child: Text(widget.product == null ? "Add Product" : "Update Product"),
              )
            ],
          ),
        ),
      ),
    );
  }
}