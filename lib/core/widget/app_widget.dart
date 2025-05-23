import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesnap/core/helper/dialog_helper.dart';
import 'package:timesnap/core/provider/app_provider.dart';
import 'package:timesnap/core/di/dependency.dart';
import 'package:flutter/widgets.dart';
import 'package:timesnap/core/widget/error_app_widget.dart';
import 'package:timesnap/core/widget/loading_app_widget.dart';

abstract class AppWidget<T extends AppProvider, P1, P2>
    extends StatelessWidget {
  AppWidget({Key? key, this.param1, this.param2}) : super(key: key);
  late T notifier;
  final P1? param1;
  final P2? param2;
  ElevatedButton? _alternatifErrorButton;

  set alternatifErrorButton(ElevatedButton? param)=>
    _alternatifErrorButton = param;
  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => sl(param1: param1, param2: param2),
      builder: (context, child) => _build(context),
    );
  }

  Widget _build(BuildContext context) {
    notifier = Provider.of<T>(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    checkVariableBeforeUi(context);
      if (notifier.snackBarMessage.isNotEmpty) {
        DialogHelper.showSnackBar(
          context: context,
          text: notifier.snackBarMessage,
        );
        notifier.snackBarMessage = '';
      }
      checkVariableAfterUi(context);
    }
  );

    return Scaffold(
      appBar: appBarBuild(context),
      body:(notifier.isLoading)
              ? LoadingAppWidget()
              : (notifier.errorMessage.isNotEmpty)
              ? ErrorAppWidget(
                description: notifier.errorMessage,
                onPressDefaultButton: () {
                  notifier.init();
                  notifier.errorMessage = '';
                },
                alternativeButton: _alternatifErrorButton,
              )
              : bodyBuild(context),
    );
  }

  void checkVariableBeforeUi(BuildContext context) {}
  void checkVariableAfterUi(BuildContext context) {}
  AppBar? appBarBuild(BuildContext context) => null;
  Widget bodyBuild(BuildContext context);
}
