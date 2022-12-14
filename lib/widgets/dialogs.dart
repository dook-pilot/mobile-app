import 'package:flutter/material.dart';
import 'package:vng_pilot/configs/colors.dart';
import 'package:vng_pilot/configs/configs.dart';

class ProgressDialog {
  BuildContext? _dialogContext;

  show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          _dialogContext = context;

          return WillPopScope(
            onWillPop: () {
              return Future<bool>.value(false);
            },
            child: Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: Material(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  elevation: 12,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          );
        });
  }

  dismiss() {
    if (_dialogContext != null) Navigator.pop(_dialogContext!);
  }
}

Widget showErrorWidget(String? errorText) {
  return Center(
    child: Material(
      color: Colors.white,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(WIDGET_RADIUS),
      ),
      child: Text(errorText ?? 'Something went wrong.'),
    ),
  );
}

showErrorDialog(BuildContext context, String? errorText, {String errorButton = "none"}) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CONTAINER_RADIUS)),
            clipBehavior: Clip.antiAlias,
            child: Material(
              color: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error, size: 60, color: errorColor.withOpacity(0.6)),
                    const SizedBox(height: 10),
                    const Text('Error', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: errorColor)),
                    const SizedBox(height: 10),
                    Text(errorText ?? 'Something went wrong.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: textDarkColor)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(WIDGET_RADIUS),
                          )),
                          elevation: MaterialStateProperty.all(3),
                          backgroundColor: MaterialStateProperty.all(primaryColor),
                          textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white))),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ));
      });
}
