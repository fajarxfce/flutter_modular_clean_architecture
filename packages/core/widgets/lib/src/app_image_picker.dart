import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// DigitalOcean-style multiple image picker with horizontal preview
class AppImagePicker extends StatefulWidget {
  final List<String>? initialImages; // URLs for existing images
  final List<File>? initialFiles; // Local files for restoration
  final ValueChanged<List<File>>? onImagesChanged;
  final int maxImages;
  final double imageSize;
  final String? label;
  final String? helperText;

  const AppImagePicker({
    super.key,
    this.initialImages,
    this.initialFiles,
    this.onImagesChanged,
    this.maxImages = 5,
    this.imageSize = 100,
    this.label,
    this.helperText,
  });

  @override
  State<AppImagePicker> createState() => _AppImagePickerState();
}

class _AppImagePickerState extends State<AppImagePicker> {
  late List<File> _selectedImages;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Initialize with provided files or empty list
    _selectedImages = widget.initialFiles != null
        ? List<File>.from(widget.initialFiles!)
        : [];
  }

  Future<void> _pickImage() async {
    if (_selectedImages.length >= widget.maxImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Maximum ${widget.maxImages} images allowed')),
      );
      return;
    }

    final List<XFile> images = await _picker.pickMultiImage();

    if (images.isNotEmpty) {
      setState(() {
        final remaining = widget.maxImages - _selectedImages.length;
        final toAdd = images.take(remaining).map((e) => File(e.path)).toList();
        _selectedImages.addAll(toAdd);
      });
      widget.onImagesChanged?.call(_selectedImages);
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
    widget.onImagesChanged?.call(_selectedImages);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 8),
        ],

        // Horizontal scrollable image list
        SizedBox(
          height: widget.imageSize + 16,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _selectedImages.length + 1,
            itemBuilder: (context, index) {
              // Add button
              if (index == _selectedImages.length) {
                return _buildAddButton(colorScheme);
              }

              // Image preview with remove button
              return _buildImageCard(index, colorScheme);
            },
          ),
        ),

        if (widget.helperText != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.helperText!,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],

        // Image counter
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            '${_selectedImages.length}/${widget.maxImages} images',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(ColorScheme colorScheme) {
    final canAddMore = _selectedImages.length < widget.maxImages;

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: canAddMore ? _pickImage : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: widget.imageSize,
          height: widget.imageSize,
          decoration: BoxDecoration(
            color: canAddMore
                ? colorScheme.primary.withOpacity(0.08)
                : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: canAddMore
                  ? colorScheme.primary.withOpacity(0.3)
                  : colorScheme.outline.withOpacity(0.3),
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_photo_alternate_outlined,
                color: canAddMore
                    ? colorScheme.primary
                    : colorScheme.onSurface.withOpacity(0.3),
                size: 32,
              ),
              const SizedBox(height: 4),
              Text(
                'Add Photo',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: canAddMore
                      ? colorScheme.primary
                      : colorScheme.onSurface.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(int index, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Stack(
        children: [
          // Image container
          Container(
            width: widget.imageSize,
            height: widget.imageSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: colorScheme.outline.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.file(_selectedImages[index], fit: BoxFit.cover),
            ),
          ),

          // Remove button (top-right)
          Positioned(
            top: 4,
            right: 4,
            child: InkWell(
              onTap: () => _removeImage(index),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: colorScheme.error,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.close, color: colorScheme.onError, size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
