import 'package:flutter/widgets.dart';
import 'package:shared/shared.dart';

abstract class BasePageState<T extends StatefulWidget, B extends Bloc>
    extends BasePageStateDelegate<T, B> {}

abstract class BasePageStateDelegate<T extends StatefulWidget, B extends Bloc>
    extends State<T> {
  late final B bloc = GetIt.instance<B>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>(
      create: (context) => bloc,
      child: Builder(builder: (context) => buildPage(context)),
    );
  }

  Widget buildPage(BuildContext context);

  void onEvent(BaseEvent event) => bloc.add(event);
}
