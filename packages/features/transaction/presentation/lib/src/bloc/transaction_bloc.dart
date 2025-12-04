import 'package:shared/shared.dart';
import 'package:transaction_presentation/src/bloc/transaction_effect.dart';
import 'package:transaction_presentation/src/bloc/transaction_event.dart';
import 'package:transaction_presentation/src/bloc/transaction_state.dart';

@injectable
class TransactionBloc
    extends BaseBloc<TransactionEvent, TransactionState, TransactionEffect> {
  TransactionBloc() : super(TransactionState()) {}
}
