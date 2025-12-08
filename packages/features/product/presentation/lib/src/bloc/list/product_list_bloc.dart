import 'package:product_domain/product_domain.dart';
import 'package:product_presentation/src/bloc/list/product_list_effect.dart';
import 'package:product_presentation/src/bloc/list/product_list_event.dart';
import 'package:product_presentation/src/bloc/list/product_list_state.dart';
import 'package:shared/shared.dart';

@injectable
class ProductListBloc
    extends BaseBloc<ProductListEvent, ProductListState, ProductListEffect> {
  final GetProductsUsecase _getProductsUsecase;

  ProductListBloc(this._getProductsUsecase)
    : super(ProductListState.initial()) {
    on<LoadProductsEvent>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductListState> emit,
  ) async {
    emit(state.copyWith(status: ProductListStatus.loading));

    try {
      final request = GetProductRequest(page: 1);
      final products = await _getProductsUsecase(request);
      products.fold(
        (failure) {
          emit(state.copyWith(status: ProductListStatus.failure));
        },
        (products) {
          emit(
            state.copyWith(
              status: ProductListStatus.success,
              products: products,
            ),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(status: ProductListStatus.failure));
    }
  }
}
