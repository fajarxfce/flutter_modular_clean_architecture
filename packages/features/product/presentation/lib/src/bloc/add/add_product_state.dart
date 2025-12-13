import 'package:shared/shared.dart';
import 'package:widgets/formz.dart';

enum AddProductStatus { initial, loading, success, failure, submitting }

class AddProductState extends BaseState {
  final AddProductStatus status;
  final TextInput name;
  final TextInput description;
  final TextInput price;

  const AddProductState({
    this.status = AddProductStatus.initial,
    this.name = const TextInput.pure(),
    this.description = const TextInput.pure(),
    this.price = const TextInput.pure(),
  });

  AddProductState copyWith({
    AddProductStatus? status,
    TextInput? name,
    TextInput? description,
    TextInput? price,
  }) {
    return AddProductState(
      status: status ?? this.status,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }

  factory AddProductState.initial() {
    return const AddProductState();
  }

  // from json
  factory AddProductState.fromJson(Map<String, dynamic> json) {
    return AddProductState(
      status: AddProductStatus.values[json['status'] as int],
      name: TextInput.dirty(json['name'] as String),
      description: TextInput.dirty(json['description'] as String),
      price: TextInput.dirty(json['price'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status.index,
      'name': name.value,
      'description': description.value,
      'price': price.value,
    };
  }

  @override
  List<Object?> get props => [status, name, description, price];
}
