import 'package:flutter/widgets.dart';
import 'package:shared/shared.dart';

abstract class BaseStateless<B extends BaseBloc>
    extends BaseStatelessDelegate<B> {
  BaseStateless({super.key});
}

abstract class BaseStatelessDelegate<B extends BaseBloc>
    extends StatelessWidget {
  late final B bloc = GetIt.instance<B>();

  BaseStatelessDelegate({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>(
      create: (context) => bloc,
      child: Builder(builder: (context) => buildPage(context)),
    );
  }

  Widget buildPage(BuildContext context);
}
