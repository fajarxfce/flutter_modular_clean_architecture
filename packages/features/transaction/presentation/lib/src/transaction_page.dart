import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:transaction_presentation/src/bloc/transaction_bloc.dart';

@RoutePage()
class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState
    extends BasePageState<TransactionPage, TransactionBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Page'),
      ),
      body: const Center(
        child: Text('This is the Transaction Page'),
      ),
    );
  }
}
