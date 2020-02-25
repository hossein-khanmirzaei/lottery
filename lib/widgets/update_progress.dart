import 'package:flutter/material.dart';
import 'package:ota_update/ota_update.dart';

class MyUpdateProgress extends StatefulWidget {
  @override
  _MyUpdateProgressState createState() => _MyUpdateProgressState();
}

class _MyUpdateProgressState extends State<MyUpdateProgress> {
  OtaEvent _currentEvent;
  //bool _isDownloadStarted = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('خطا!'),
        content: Text(
          message,
          textAlign: TextAlign.justify,
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Theme.of(context).accentColor,
            color: Theme.of(context).primaryColor,
            child: Text('بستن'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> tryOtaUpdate() async {
    try {
      //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
      OtaUpdate()
          .execute('https://silvana-tnk.com/app.apk',
              destinationFilename: 'app.apk')
          .listen(
        (OtaEvent event) {
          setState(() => _currentEvent = event);
          switch (event.status) {
            case OtaStatus.ALREADY_RUNNING_ERROR:
              {
                _showErrorDialog('دانلود قبلا شروع شده است!');
                break;
              }
            case OtaStatus.DOWNLOAD_ERROR:
              {
                _showErrorDialog('خطا در دریافت فایل به-روزرسانی!');
                break;
              }
            case OtaStatus.DOWNLOADING:
              {
                //_isDownloadStarted = true;
                break;
              }
            case OtaStatus.INSTALLING:
              {
                Navigator.pop(context);
                break;
              }
            case OtaStatus.INTERNAL_ERROR:
              {
                _showErrorDialog('خطا در به-روز رسانی!');
                break;
              }
            case OtaStatus.PERMISSION_NOT_GRANTED_ERROR:
              {
                _showErrorDialog('خطای دسترسی!');
                break;
              }
          }
        },
      );
    } catch (e) {
      _showErrorDialog('خطا در به-روز رسانی!');
    }
  }

  @override
  void initState() {
    tryOtaUpdate();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDownloadStarted =
        _currentEvent?.status == OtaStatus.DOWNLOADING ?? false;
    return isDownloadStarted
        ? LinearProgressIndicator(
            value: double.parse(_currentEvent.value) / 100,
          )
        : Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          );
  }
}
