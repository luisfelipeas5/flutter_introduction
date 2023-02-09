import 'package:flutter_introduction/failure.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToaster {
  const AppToaster();

  void showFailureToast(
    Failure failure,
  ) {
    Fluttertoast.showToast(
      msg: failure.message,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
