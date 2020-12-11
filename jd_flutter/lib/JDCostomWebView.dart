import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String selectedUrl = 'https://prodev.m.jd.com/mall/active/2hT2gWWUWAANbs7Dio1wyrjFvKoq/index.html';

class JDCustomWebview extends StatefulWidget {
  final String title;
  final String url;

  const JDCustomWebview({
    this.title,
    this.url,
});

  @override
  _JDCustomWebviewState createState() => _JDCustomWebviewState();
}

class _JDCustomWebviewState extends State<JDCustomWebview> {

   String title;
   String url;

   @override
  void initState() {
    super.initState();
    setState(() {
      title = widget.title;
      url = widget.url;
    });
  }

  // // Instance of WebView plugin
  // final flutterWebViewPlugin = FlutterWebviewPlugin();
  //
  // // On destroy stream
  // StreamSubscription _onDestroy;
  //
  // // On urlChanged stream
  // StreamSubscription<String> _onUrlChanged;
  //
  // // On urlChanged stream
  // StreamSubscription<WebViewStateChanged> _onStateChanged;
  //
  // StreamSubscription<WebViewHttpError> _onHttpError;
  //
  // StreamSubscription<double> _onProgressChanged;
  //
  // StreamSubscription<double> _onScrollYChanged;
  //
  // StreamSubscription<double> _onScrollXChanged;
  //
  // final _urlCtrl = TextEditingController(text: selectedUrl);
  //
  // final _codeCtrl = TextEditingController(text: 'window.navigator.userAgent');
  //
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  //
  // final _history = [];
  //
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   flutterWebViewPlugin.close();
  //
  //   _urlCtrl.addListener(() {
  //     selectedUrl = _urlCtrl.text;
  //   });
  //
  //   // Add a listener to on destroy WebView, so you can make came actions.
  //   _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
  //     if (mounted) {
  //       // Actions like show a info toast.
  //       _scaffoldKey.currentState.showSnackBar(
  //           const SnackBar(content: const Text('Webview Destroyed')));
  //     }
  //   });
  //
  //   // Add a listener to on url changed
  //   _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
  //     if (mounted) {
  //       setState(() {
  //         _history.add('onUrlChanged: $url');
  //       });
  //     }
  //   });
  //
  //   _onProgressChanged =
  //       flutterWebViewPlugin.onProgressChanged.listen((double progress) {
  //         if (mounted) {
  //           setState(() {
  //             _history.add('onProgressChanged: $progress');
  //           });
  //         }
  //       });
  //
  //   _onScrollYChanged =
  //       flutterWebViewPlugin.onScrollYChanged.listen((double y) {
  //         if (mounted) {
  //           setState(() {
  //             _history.add('Scroll in Y Direction: $y');
  //           });
  //         }
  //       });
  //
  //   _onScrollXChanged =
  //       flutterWebViewPlugin.onScrollXChanged.listen((double x) {
  //         if (mounted) {
  //           setState(() {
  //             _history.add('Scroll in X Direction: $x');
  //           });
  //         }
  //       });
  //
  //   _onStateChanged =
  //       flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
  //         if (mounted) {
  //           setState(() {
  //             _history.add('onStateChanged: ${state.type} ${state.url}');
  //           });
  //         }
  //       });
  //
  //   _onHttpError =
  //       flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
  //         if (mounted) {
  //           setState(() {
  //             _history.add('onHttpError: ${error.code} ${error.url}');
  //           });
  //         }
  //       });
  //
  // }
  //
  // @override
  // void dispose() {
  //   // Every listener should be canceled, the same should be done with this stream.
  //   _onDestroy.cancel();
  //   _onUrlChanged.cancel();
  //   _onStateChanged.cancel();
  //   _onHttpError.cancel();
  //   _onProgressChanged.cancel();
  //   _onScrollXChanged.cancel();
  //   _onScrollYChanged.cancel();
  //
  //   flutterWebViewPlugin.dispose();
  //
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      routes: {
        '/': (_) => new WebviewScaffold(
         url: url,
          useWideViewPort: true,
          displayZoomControls: true,
          withOverviewMode: true,
          appBar: AppBar(
            title:  Text(title),
              leading: IconButton(
                icon:  Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
          ),
         ),
      },
    );
    
  /*  return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('123'),
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              child: TextField(controller: _urlCtrl),
            ),
            // RaisedButton(
            //   onPressed: () {
            //     flutterWebViewPlugin.launch(
            //       selectedUrl,
            //       rect: Rect.fromLTWH(
            //           0.0, 0.0, MediaQuery.of(context).size.width, 300.0),
            //       userAgent: kAndroidUserAgent,
            //       invalidUrlRegex:
            //       r'^(https).+(twitter)', // prevent redirecting to twitter when user click on its icon in flutter website
            //     );
            //   },
            //   child: const Text('Open Webview (rect)'),
            // ),
            RaisedButton(
              onPressed: () {
                flutterWebViewPlugin.launch(selectedUrl, hidden: true);
              },
              child: const Text('Open "hidden" Webview'),
            ),
            RaisedButton(
              onPressed: () {
                flutterWebViewPlugin.launch(selectedUrl);
              },
              child: const Text('Open Fullscreen Webview'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/widget');
              },
              child: const Text('Open widget webview'),
            ),
            Container(
              padding: const EdgeInsets.all(24.0),
              child: TextField(controller: _codeCtrl),
            ),
            RaisedButton(
              onPressed: () {
                final future =
                flutterWebViewPlugin.evalJavascript(_codeCtrl.text);
                future.then((String result) {
                  setState(() {
                    _history.add('eval: $result');
                  });
                });
              },
              child: const Text('Eval some javascript'),
            ),
            RaisedButton(
              onPressed: () {
                final future = flutterWebViewPlugin.evalJavascript('alert("Hello World");');
                future.then((String result) {
                  setState(() {
                    _history.add('eval: $result');
                  });
                });
              },
              child: const Text('Eval javascript alert()'),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _history.clear();
                });
                flutterWebViewPlugin.close();
              },
              child: const Text('Close'),
            ),
            RaisedButton(
              onPressed: () {
                flutterWebViewPlugin.getCookies().then((m) {
                  setState(() {
                    _history.add('cookies: $m');
                  });
                });
              },
              child: const Text('Cookies'),
            ),
            Text(_history.join('\n'))

          ],
        ),
      ),
    ); 
     */
  }
}


