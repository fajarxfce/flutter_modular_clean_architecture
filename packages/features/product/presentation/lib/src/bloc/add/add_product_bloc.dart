import 'dart:math';

import 'package:blocfx/blocfx.dart';
import 'package:product_presentation/src/bloc/add/add_product_effect.dart';
import 'package:product_presentation/src/bloc/add/add_product_event.dart';
import 'package:product_presentation/src/bloc/add/add_product_state.dart';
import 'package:shared/shared.dart';
import 'package:widgets/formz.dart';

@injectable
class AddProductBloc
    extends
        PersistedBlocFx<AddProductEvent, AddProductState, AddProductEffect> {
  AddProductBloc() : super(AddProductState.initial()) {
    on<SaveProductEvent>(_onSaveProduct);
    on<NameChangedEvent>(_onNameChanged);
    on<PriceChangedEvent>(_onPriceChanged);
    on<DescriptionChangedEvent>(_onDescriptionChanged);
    on<ImagesChangedEvent>(_onImagesChanged);
  }

  @override
  AddProductState fromJson(Map<String, dynamic> json) =>
      AddProductState.fromJson(json);

  @override
  String get storageKey => 'add_product_bloc';

  @override
  Map<String, dynamic> toJson(AddProductState state) => state.toJson();

  Future<void> _onSaveProduct(
    SaveProductEvent event,
    Emitter<AddProductState> emit,
  ) async {
    emit(state.copyWith(status: AddProductStatus.submitting));
    await Future.delayed(const Duration(seconds: 4));
    final success = Random().nextInt(100) % 2 == 0;
    if (!success) {
      emit(state.copyWith(status: AddProductStatus.failure));
      emitEffect(ProductAddFailedEffect('Failed to add product'));
      return;
    }
    emit(state.copyWith(status: AddProductStatus.success));
    emitEffect(ProductAddedEffect());
  }

  Future<void> _onNameChanged(
    NameChangedEvent event,
    Emitter<AddProductState> emit,
  ) async {
    final nameInput = TextInput.dirty(event.name);
    emit(state.copyWith(name: nameInput));
  }

  Future<void> _onPriceChanged(
    PriceChangedEvent event,
    Emitter<AddProductState> emit,
  ) async {
    final priceInput = TextInput.dirty(event.price);
    emit(state.copyWith(price: priceInput));
  }

  Future<void> _onDescriptionChanged(
    DescriptionChangedEvent event,
    Emitter<AddProductState> emit,
  ) async {
    final descriptionInput = TextInput.dirty(event.description);
    emit(state.copyWith(description: descriptionInput));
  }

  Future<void> _onImagesChanged(
    ImagesChangedEvent event,
    Emitter<AddProductState> emit,
  ) async {
    // Custom validation (not Formz)
    String? error;
    if (event.imagePaths.isEmpty) {
      error = 'Please add at least one image';
    } else if (event.imagePaths.length > 5) {
      error = 'Maximum 5 images allowed';
    }

    emit(state.copyWith(imagePaths: event.imagePaths, imageError: error));
  }
}
