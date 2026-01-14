// lib/Admin/product_form.dart - Web Compatible

// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;
import 'package:image_picker/image_picker.dart';
import 'package:laptop_harbor/models/laptop_model.dart';
import 'package:laptop_harbor/services/firestore_service.dart';
import 'package:laptop_harbor/services/firebase_storage_service.dart';

class ProductFormScreen extends StatefulWidget {
  final LaptopModel? laptop;
  
  const ProductFormScreen({
    super.key,
    this.laptop,
  });

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseStorageService _storageService = FirebaseStorageService();

  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _brandController;
  late TextEditingController _imageUrlController;
  late TextEditingController _priceController;
  late TextEditingController _originalPriceController;
  late TextEditingController _processorController;
  late TextEditingController _ramController;
  late TextEditingController _storageController;
  late TextEditingController _displayController;
  late TextEditingController _ratingController;
  late TextEditingController _reviewsController;
  late TextEditingController _categoryController;
  late TextEditingController _featuresController;

  // States
  bool _inStock = true;
  bool _isHotDeal = false;
  bool _isMostSale = false;
  bool _isNewArrival = false;
  bool _isLoading = false;
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  // Image
  XFile? _selectedImage;
  String? _imageUrl;
  Uint8List? _webImageBytes; // For web image preview

  final List<String> _categories = [
    'Gaming',
    'Business',
    'Student',
    'Premium',
    'Budget',
    'Workstation',
    'Ultrabook',
    'General',
  ];

  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _imageUrl = widget.laptop?.imageUrl;
  }

  void _initializeControllers() {
    final laptop = widget.laptop;
    
    _nameController = TextEditingController(text: laptop?.name ?? '');
    _brandController = TextEditingController(text: laptop?.brand ?? '');
    _imageUrlController = TextEditingController(text: laptop?.imageUrl ?? '');
    _priceController = TextEditingController(text: laptop?.price.toString() ?? '');
    _originalPriceController = TextEditingController(text: laptop?.originalPrice.toString() ?? '');
    _processorController = TextEditingController(text: laptop?.processor ?? '');
    _ramController = TextEditingController(text: laptop?.ram.toString() ?? '');
    _storageController = TextEditingController(text: laptop?.storage.toString() ?? '');
    _displayController = TextEditingController(text: laptop?.display ?? '');
    _ratingController = TextEditingController(text: laptop?.rating.toString() ?? '4.5');
    _reviewsController = TextEditingController(text: laptop?.reviews.toString() ?? '0');
    _categoryController = TextEditingController(text: laptop?.category ?? '');
    _featuresController = TextEditingController(text: laptop?.features.join(', ') ?? '');

    if (laptop != null) {
      _selectedCategory = laptop.category;
      _inStock = laptop.inStock;
      _isHotDeal = laptop.isHotDeal;
      _isMostSale = laptop.isMostSale;
      _isNewArrival = laptop.isNewArrival;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _imageUrlController.dispose();
    _priceController.dispose();
    _originalPriceController.dispose();
    _processorController.dispose();
    _ramController.dispose();
    _storageController.dispose();
    _displayController.dispose();
    _ratingController.dispose();
    _reviewsController.dispose();
    _categoryController.dispose();
    _featuresController.dispose();
    super.dispose();
  }

  // ================= IMAGE UPLOAD (WEB) =================
  Future<void> _pickAndUploadImage() async {
    try {
      // Pick image
      final XFile? image = await _storageService.pickImageFromGallery();
      
      if (image == null) return;

      setState(() {
        _selectedImage = image;
        _isUploading = true;
        _uploadProgress = 0.0;
      });

      // Read bytes for web preview
      if (kIsWeb) {
        _webImageBytes = await image.readAsBytes();
        setState(() {});
      }

      // Upload to Firebase Storage
      final String? uploadedUrl = await _storageService.uploadImage(image);

      if (uploadedUrl != null) {
        setState(() {
          _imageUrl = uploadedUrl;
          _imageUrlController.text = uploadedUrl;
          _isUploading = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Image uploaded successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        throw Exception('Upload failed');
      }
    } catch (e) {
      setState(() {
        _isUploading = false;
        _selectedImage = null;
        _webImageBytes = null;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _webImageBytes = null;
      _imageUrl = null;
      _imageUrlController.clear();
    });
  }

  // ================= SAVE LAPTOP =================
  Future<void> _saveLaptop() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_imageUrl == null || _imageUrl!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Please upload an image'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final double price = double.parse(_priceController.text);
      final double originalPrice = double.parse(_originalPriceController.text);
      final double discount = originalPrice > 0 
          ? ((originalPrice - price) / originalPrice) * 100 
          : 0.0;

      final laptop = LaptopModel(
        id: widget.laptop?.id ?? '',
        name: _nameController.text.trim(),
        brand: _brandController.text.trim(),
        imageUrl: _imageUrl!,
        price: price,
        originalPrice: originalPrice,
        processor: _processorController.text.trim(),
        ram: int.parse(_ramController.text),
        storage: int.parse(_storageController.text),
        display: _displayController.text.trim(),
        rating: double.parse(_ratingController.text),
        reviews: int.parse(_reviewsController.text),
        inStock: _inStock,
        features: _featuresController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        category: _selectedCategory ?? _categoryController.text.trim(),
        isHotDeal: _isHotDeal,
        isMostSale: _isMostSale,
        isNewArrival: _isNewArrival,
        discount: discount,
      );

      bool success = false;
      if (widget.laptop != null) {
        success = await _firestoreService.updateLaptop(widget.laptop!.id, laptop);
      } else {
        final id = await _firestoreService.addLaptop(laptop);
        success = id != null;
      }

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.laptop != null
                    ? '✅ Product updated successfully'
                    : '✅ Product added successfully',
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        } else {
          throw Exception('Failed to save product');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.laptop != null ? 'Edit Product' : 'Add New Product'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ================= IMAGE SECTION =================
            _buildSectionHeader('Product Image'),
            Center(
              child: Container(
                width: 400,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[400]!, width: 2),
                ),
                child: _isUploading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 16),
                          Text(
                            'Uploading...',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      )
                    : (_imageUrl != null || _webImageBytes != null)
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: _webImageBytes != null
                                    ? Image.memory(
                                        _webImageBytes!,
                                        width: 400,
                                        height: 300,
                                        fit: BoxFit.contain,
                                      )
                                    : Image.network(
                                        _imageUrl!,
                                        width: 400,
                                        height: 300,
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Center(
                                            child: Icon(Icons.error, size: 50, color: Colors.red),
                                          );
                                        },
                                      ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      child: IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.white),
                                        onPressed: _pickAndUploadImage,
                                        tooltip: 'Change Image',
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.white),
                                        onPressed: _removeImage,
                                        tooltip: 'Remove Image',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : InkWell(
                            onTap: _pickAndUploadImage,
                            borderRadius: BorderRadius.circular(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload,
                                  size: 80,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Click to upload image',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Supports: JPG, PNG (Max 5MB)',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
              ),
            ),
            const SizedBox(height: 32),

            // ================= FORM FIELDS =================
            _buildSectionHeader('Basic Information'),
            _buildTextField(
              controller: _nameController,
              label: 'Product Name',
              icon: Icons.laptop,
              required: true,
            ),
            const SizedBox(height: 16),
            
            _buildTextField(
              controller: _brandController,
              label: 'Brand',
              icon: Icons.business,
              required: true,
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Pricing'),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _priceController,
                    label: 'Sale Price',
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                    required: true,
                    prefix: '₹',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _originalPriceController,
                    label: 'Original Price',
                    icon: Icons.money_off,
                    keyboardType: TextInputType.number,
                    required: true,
                    prefix: '₹',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Specifications'),
            _buildTextField(
              controller: _processorController,
              label: 'Processor',
              icon: Icons.memory,
              required: true,
              hint: 'e.g., Intel Core i7-12700H',
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _ramController,
                    label: 'RAM (GB)',
                    icon: Icons.dns,
                    keyboardType: TextInputType.number,
                    required: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _storageController,
                    label: 'Storage (GB)',
                    icon: Icons.storage,
                    keyboardType: TextInputType.number,
                    required: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            _buildTextField(
              controller: _displayController,
              label: 'Display',
              icon: Icons.monitor,
              required: true,
              hint: 'e.g., 15.6" FHD IPS',
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Category & Features'),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Category',
                prefixIcon: const Icon(Icons.category),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              items: _categories.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedCategory = value);
                _categoryController.text = value ?? '';
              },
              validator: (v) => v == null ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            
            _buildTextField(
              controller: _featuresController,
              label: 'Features (comma separated)',
              icon: Icons.star,
              maxLines: 3,
              hint: 'Backlit Keyboard, Fingerprint Reader, Wi-Fi 6',
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Ratings & Reviews'),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _ratingController,
                    label: 'Rating (0-5)',
                    icon: Icons.star_rate,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _reviewsController,
                    label: 'Reviews Count',
                    icon: Icons.rate_review,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Status & Tags'),
            Card(
              elevation: 0,
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('In Stock'),
                      value: _inStock,
                      onChanged: (v) => setState(() => _inStock = v),
                      secondary: const Icon(Icons.inventory_2),
                    ),
                    SwitchListTile(
                      title: const Text('Hot Deal 🔥'),
                      value: _isHotDeal,
                      onChanged: (v) => setState(() => _isHotDeal = v),
                      secondary: const Icon(Icons.local_fire_department),
                    ),
                    SwitchListTile(
                      title: const Text('Most Sale 💰'),
                      value: _isMostSale,
                      onChanged: (v) => setState(() => _isMostSale = v),
                      secondary: const Icon(Icons.trending_up),
                    ),
                    SwitchListTile(
                      title: const Text('New Arrival ✨'),
                      value: _isNewArrival,
                      onChanged: (v) => setState(() => _isNewArrival = v),
                      secondary: const Icon(Icons.new_releases),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Save Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading || _isUploading ? null : _saveLaptop,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        widget.laptop != null ? 'Update Product' : 'Add Product',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool required = false,
    String? hint,
    String? prefix,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        hintText: hint,
        prefixIcon: Icon(icon),
        prefixText: prefix,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: required
          ? (v) => v?.isEmpty ?? true ? 'This field is required' : null
          : null,
    );
  }
}