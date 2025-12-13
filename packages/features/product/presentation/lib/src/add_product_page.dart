import 'dart:io';

import 'package:blocfx/blocfx.dart';
import 'package:flutter/material.dart';
import 'package:product_presentation/src/bloc/add/add_product_bloc.dart';
import 'package:product_presentation/src/bloc/add/add_product_effect.dart';
import 'package:product_presentation/src/bloc/add/add_product_event.dart';
import 'package:product_presentation/src/bloc/add/add_product_state.dart';
import 'package:shared/shared.dart';
import 'package:widgets/formz.dart';
import 'package:widgets/widgets.dart';

@RoutePage()
class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState
    extends BasePageState<AddProductPage, AddProductBloc> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = bloc.state;
      if (state.name.value.isNotEmpty) {
        nameController.text = state.name.value;
      }
      if (state.description.value.isNotEmpty) {
        descriptionController.text = state.description.value;
      }
      if (state.price.value.isNotEmpty) {
        priceController.text = state.price.value;
      }
    });

    nameController.addListener(() {
      bloc.add(NameChangedEvent(nameController.text));
    });
    descriptionController.addListener(() {
      bloc.add(DescriptionChangedEvent(descriptionController.text));
    });
    priceController.addListener(() {
      bloc.add(PriceChangedEvent(priceController.text));
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body:
          BlocFxListener<
            AddProductBloc,
            AddProductEvent,
            AddProductState,
            AddProductEffect
          >(
            listener: (context, state) {
              if (state is ProductAddedEffect) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product added successfully')),
                );
              } else if (state is ProductAddFailedEffect) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _productForm(),
            ),
          ),
    );
  }

  Widget _productForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Name field with Formz validation
        BlocSelector<AddProductBloc, AddProductState, TextInput>(
          selector: (state) => state.name,
          builder: (context, name) {
            return AppTextField(
              controller: nameController,
              label: 'Name',
              errorText: name.isPure ? null : name.errorMessage,
            );
          },
        ),
        const SizedBox(height: 16),

        // Description field
        BlocSelector<AddProductBloc, AddProductState, TextInput>(
          selector: (state) => state.description,
          builder: (context, description) {
            return AppTextField(
              controller: descriptionController,
              label: 'Description',
              maxLines: 3,
              errorText: description.isPure ? null : description.errorMessage,
            );
          },
        ),
        const SizedBox(height: 16),

        // Price field
        BlocSelector<AddProductBloc, AddProductState, TextInput>(
          selector: (state) => state.price,
          builder: (context, price) {
            return AppTextField(
              controller: priceController,
              label: 'Price',
              keyboardType: TextInputType.number,
              errorText: price.isPure ? null : price.errorMessage,
            );
          },
        ),
        const SizedBox(height: 24),

        BlocSelector<
          AddProductBloc,
          AddProductState,
          ({String? imageError, List<String> imagePaths})
        >(
          selector: (state) =>
              (imageError: state.imageError, imagePaths: state.imagePaths),
          builder: (context, value) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppImagePicker(
                  maxImages: 5,
                  imageSize: 100,
                  label: 'Product Images',
                  helperText: 'Add up to 5 images for this product',
                  initialFiles: value.imagePaths
                      .map((path) => File(path))
                      .toList(),
                  onImagesChanged: (images) {
                    final paths = images.map((file) => file.path).toList();
                    bloc.add(ImagesChangedEvent(paths));
                  },
                ),
                if (value.imageError != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    value.imageError ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
        const SizedBox(height: 24),

        // Submit button
        BlocSelector<AddProductBloc, AddProductState, AddProductStatus>(
          selector: (state) => state.status,
          builder: (context, status) {
            final isLoading = status == AddProductStatus.loading;
            final isValid = context.select(
              (AddProductBloc bloc) =>
                  Formz.validate([
                    bloc.state.name,
                    bloc.state.description,
                    bloc.state.price,
                  ]) &&
                  bloc.state.hasValidImages, // Include image validation
            );

            return AppButton.primary(
              onPressed: isLoading || !isValid
                  ? null
                  : () => bloc.add(SaveProductEvent()),
              text: isLoading ? 'Submitting...' : 'Add Product',
            );
          },
        ),
      ],
    );
  }
}
