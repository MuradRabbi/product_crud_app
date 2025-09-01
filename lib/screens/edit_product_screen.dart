import 'package:flutter/material.dart';


class EditProductScreen extends StatefulWidget {
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final product = {
        "name": nameController.text,
        "code": codeController.text,
        "quantity": quantityController.text,
        "unitPrice": priceController.text,
        "imageUrl": imageUrlController.text,
      };


      print("Product Saved: $product");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product Edited Successfully")),
      );
      nameController.clear();
      codeController.clear();
      quantityController.clear();
      priceController.clear();
      imageUrlController.clear();
    }
  }

  Widget _buildTextField(
      {required String label,
        required TextEditingController controller,
        TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$label is required";
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(label: "Product Name", controller: nameController),
                SizedBox(height: 12),
                _buildTextField(label: "Product Code", controller: codeController),
                SizedBox(height: 12),
                _buildTextField(
                  label: "Quantity",
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                _buildTextField(
                  label: "Unit Price",
                  controller: priceController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                _buildTextField(
                  label: "Image URL",
                  controller: imageUrlController,
                  keyboardType: TextInputType.url,
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _saveProduct,
                  icon: Icon(Icons.save),
                  label: Text("Edit Product"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    codeController.dispose();
    quantityController.dispose();
    priceController.dispose();
    imageUrlController.dispose();
  }
}
