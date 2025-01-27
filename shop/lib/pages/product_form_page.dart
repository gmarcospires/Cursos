import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Map<String, Object> _formData = {};

  void _updateImageUrl() {
    setState(() {});
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<ProductList>(context, listen: false).saveProduct(_formData);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _imageUrlFocus.removeListener(_updateImageUrl);
    _imageUrlFocus.dispose();
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;

        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = _formData['imageUrl'] as String;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _submitForm,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _formData['name'] as String?,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  onSaved: (newValue) => _formData['name'] = newValue ?? '',
                  validator: (value) {
                    final name = value ?? '';
                    if (name.trim().isEmpty) {
                      return 'Nome é obrigatório';
                    }
                    if (name.trim().length < 3) {
                      return 'Nome precisa ter no mínimo 3 letras';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['price']?.toString(),
                  decoration: const InputDecoration(labelText: 'Preço'),
                  focusNode: _priceFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onSaved: (newValue) =>
                      _formData['price'] = double.parse(newValue ?? ''),
                  validator: (value) {
                    final price = double.tryParse(value ?? '');

                    if (price == null || price <= 0) {
                      return 'Informe um preço válido';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['description'] as String?,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onSaved: (newValue) =>
                      _formData['description'] = newValue ?? '',
                  validator: (value) {
                    final description = value ?? '';
                    if (description.trim().isEmpty) {
                      return 'Descrição é obrigatória';
                    }
                    if (description.trim().length < 10) {
                      return 'Descrição precisa ter no mínimo 10 letras';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'URL da Imagem'),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.url,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocus,
                        onFieldSubmitted: (_) => _submitForm(),
                        onSaved: (newValue) =>
                            _formData['imageUrl'] = newValue ?? '',
                        validator: (value) {
                          final imageUrl = value ?? '';
                          if (imageUrl.trim().isEmpty) {
                            return 'URL é obrigatória';
                          }
                          if (!imageUrl.startsWith('http') ||
                              !imageUrl.startsWith('https')) {
                            return 'Informe uma URL válida';
                          }

                          // if (!imageUrl.endsWith('.png') &&
                          //     !imageUrl.endsWith('.jpg') &&
                          //     !imageUrl.endsWith('.jpeg') &&
                          //     !imageUrl.endsWith('.webp')) {
                          //   return 'Informe uma URL de imagem válida';
                          // }

                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 10),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Center(
                              child: Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.grey,
                              ),
                            )
                          : FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(_imageUrlController.text),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
