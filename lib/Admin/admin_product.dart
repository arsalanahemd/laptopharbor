import 'package:flutter/material.dart';

// ✅ Export this file as: admin/admin_product_form.dart
// Products Page with Add/Edit Form (Mobile Responsive)
class AddProductsPage extends StatefulWidget {
  const AddProductsPage({super.key});

  @override
  State<AddProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<AddProductsPage> {
  List<Product> products = [
    Product(
      id: '1',
      name: 'MacBook Pro M3',
      brand: 'Apple',
      price: 1999,
      stock: 15,
      category: 'Ultrabook',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      id: '2',
      name: 'Dell XPS 15',
      brand: 'Dell',
      price: 1499,
      stock: 23,
      category: 'Business',
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) => ProductFormDialog(
        onSave: (product) {
          setState(() {
            products.add(product);
          });
        },
      ),
    );
  }

  void _showEditProductDialog(Product product) {
    showDialog(
      context: context,
      builder: (context) => ProductFormDialog(
        product: product,
        onSave: (updatedProduct) {
          setState(() {
            final index = products.indexWhere((p) => p.id == updatedProduct.id);
            if (index != -1) {
              products[index] = updatedProduct;
            }
          });
        },
      ),
    );
  }

  void _deleteProduct(String id) {
    setState(() {
      products.removeWhere((p) => p.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Padding(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Products',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _showAddProductDialog,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Product'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Products Management',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _showAddProductDialog,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Product'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 24),
          // Product List
          Expanded(
            child: isMobile ? _buildMobileList() : _buildDesktopTable(),
          ),
        ],
      ),
    );
  }

  // Desktop Table View
  Widget _buildDesktopTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Row(
              children: const [
                Expanded(flex: 2, child: Text('Product', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Brand', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Category', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Stock', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Image', style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(width: 120, child: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          // Table Body
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(child: Text(product.brand)),
                      Expanded(child: Text(product.category)),
                      Expanded(child: Text('\$${product.price}')),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: product.stock > 10
                                ? const Color(0xFF10B981).withOpacity(0.1)
                                : const Color(0xFFF59E0B).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${product.stock}',
                            style: TextStyle(
                              color: product.stock > 10 ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: product.imageUrl != null
                            ? Image.network(
                                product.imageUrl!,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                              )
                            : const Icon(Icons.image),
                      ),
                      SizedBox(
                        width: 120,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => _showEditProductDialog(product),
                              icon: const Icon(Icons.edit, size: 20),
                              color: const Color(0xFF3B82F6),
                            ),
                            IconButton(
                              onPressed: () => _deleteProduct(product.id),
                              icon: const Icon(Icons.delete, size: 20),
                              color: const Color(0xFFEF4444),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Mobile List View
  Widget _buildMobileList() {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.imageUrl != null && product.imageUrl!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.imageUrl!,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 160,
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: const Text(
                          'Invalid Image URL',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${product.brand} • ${product.category}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: product.stock > 10
                            ? const Color(0xFF10B981).withOpacity(0.1)
                            : const Color(0xFFF59E0B).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Stock: ${product.stock}',
                        style: TextStyle(
                          color: product.stock > 10 ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => _showEditProductDialog(product),
                          icon: const Icon(Icons.edit, size: 20),
                          color: const Color(0xFF3B82F6),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () => _deleteProduct(product.id),
                          icon: const Icon(Icons.delete, size: 20),
                          color: const Color(0xFFEF4444),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Product Form Dialog
class ProductFormDialog extends StatefulWidget {
  final Product? product;
  final Function(Product) onSave;

  const ProductFormDialog({
    Key? key,
    this.product,
    required this.onSave,
  }) : super(key: key);

  @override
  State<ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<ProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _brandController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late TextEditingController _processorController;
  late TextEditingController _ramController;
  late TextEditingController _storageController;
  late TextEditingController _displayController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController; // ✅ NEW

  String _selectedCategory = 'Gaming';
  final List<String> _categories = ['Gaming', 'Business', 'Ultrabook', 'Student', 'Budget'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _brandController = TextEditingController(text: widget.product?.brand ?? '');
    _priceController = TextEditingController(text: widget.product?.price.toString() ?? '');
    _stockController = TextEditingController(text: widget.product?.stock.toString() ?? '');
    _processorController = TextEditingController(text: widget.product?.processor ?? '');
    _ramController = TextEditingController(text: widget.product?.ram ?? '');
    _storageController = TextEditingController(text: widget.product?.storage ?? '');
    _displayController = TextEditingController(text: widget.product?.display ?? '');
    _descriptionController = TextEditingController(text: widget.product?.description ?? '');
    _imageController = TextEditingController(text: widget.product?.imageUrl ?? ''); // ✅ NEW
    _selectedCategory = widget.product?.category ?? 'Gaming';

    // Image live preview
    _imageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _processorController.dispose();
    _ramController.dispose();
    _storageController.dispose();
    _displayController.dispose();
    _descriptionController.dispose();
    _imageController.dispose(); // ✅ NEW
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        brand: _brandController.text,
        price: double.parse(_priceController.text),
        stock: int.parse(_stockController.text),
        category: _selectedCategory,
        processor: _processorController.text,
        ram: _ramController.text,
        storage: _storageController.text,
        display: _displayController.text,
        description: _descriptionController.text,
        imageUrl: _imageController.text.isEmpty ? null : _imageController.text, // ✅ NEW
      );
      widget.onSave(product);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 800,
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.product == null ? 'Add New Product' : 'Edit Product',
                        style: TextStyle(
                          fontSize: isMobile ? 20 : 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 16 : 24),
                // Name & Brand
                isMobile
                    ? Column(
                        children: [
                          _buildTextField(controller: _nameController, label: 'Product Name', hint: 'MacBook Pro M3', validator: (v) => v!.isEmpty ? 'Required' : null),
                          const SizedBox(height: 16),
                          _buildTextField(controller: _brandController, label: 'Brand', hint: 'Apple', validator: (v) => v!.isEmpty ? 'Required' : null),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(child: _buildTextField(controller: _nameController, label: 'Product Name', hint: 'MacBook Pro M3', validator: (v) => v!.isEmpty ? 'Required' : null)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildTextField(controller: _brandController, label: 'Brand', hint: 'Apple', validator: (v) => v!.isEmpty ? 'Required' : null)),
                        ],
                      ),
                const SizedBox(height: 16),
                // Price, Stock, Category
                isMobile
                    ? Column(
                        children: [
                          _buildTextField(controller: _priceController, label: 'Price (\$)', hint: '1999', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                          const SizedBox(height: 16),
                          _buildTextField(controller: _stockController, label: 'Stock', hint: '10', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                          const SizedBox(height: 16),
                          _buildCategoryDropdown(),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(child: _buildTextField(controller: _priceController, label: 'Price (\$)', hint: '1999', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildTextField(controller: _stockController, label: 'Stock', hint: '10', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildCategoryDropdown()),
                        ],
                      ),
                const SizedBox(height: 16),
                // Specifications
                isMobile
                    ? Column(
                        children: [
                          _buildTextField(controller: _processorController, label: 'Processor', hint: 'M3 Pro'),
                          const SizedBox(height: 16),
                          _buildTextField(controller: _ramController, label: 'RAM', hint: '16GB'),
                          const SizedBox(height: 16),
                          _buildTextField(controller: _storageController, label: 'Storage', hint: '512GB SSD'),
                          const SizedBox(height: 16),
                          _buildTextField(controller: _displayController, label: 'Display', hint: '14" Retina'),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: _buildTextField(controller: _processorController, label: 'Processor', hint: 'M3 Pro')),
                              const SizedBox(width: 16),
                              Expanded(child: _buildTextField(controller: _ramController, label: 'RAM', hint: '16GB')),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(child: _buildTextField(controller: _storageController, label: 'Storage', hint: '512GB SSD')),
                              const SizedBox(width: 16),
                              Expanded(child: _buildTextField(controller: _displayController, label: 'Display', hint: '14" Retina')),
                            ],
                          ),
                        ],
                      ),
                const SizedBox(height: 16),
                // Description
                _buildTextField(controller: _descriptionController, label: 'Description', hint: 'Enter product description...', maxLines: 4),
                const SizedBox(height: 16),
                // ✅ Image URL
                _buildTextField(controller: _imageController, label: 'Product Image URL', hint: 'https://example.com/image.png'),
                const SizedBox(height: 12),
                if (_imageController.text.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      _imageController.text,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 160,
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: const Text(
                          'Invalid Image URL',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: isMobile ? 20 : 24),
                // Buttons
                isMobile
                    ? Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _saveProduct,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3B82F6),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Save Product'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: _saveProduct,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3B82F6),
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Save Product'),
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

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          items: _categories.map((cat) {
            return DropdownMenuItem(value: cat, child: Text(cat));
          }).toList(),
          onChanged: (value) => setState(() => _selectedCategory = value!),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          validator: validator,
        ),
      ],
    );
  }
}

// Product Model
class Product {
  final String id;
  final String name;
  final String brand;
  final double price;
  final int stock;
  final String category;
  final String? processor;
  final String? ram;
  final String? storage;
  final String? display;
  final String? description;
  final String? imageUrl; // ✅ NEW

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.stock,
    required this.category,
    this.processor,
    this.ram,
    this.storage,
    this.display,
    this.description,
    this.imageUrl, // ✅ NEW
  });
}
