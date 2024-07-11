import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({required this.file, super.key});
  final File file;

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int pages = 0;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isReady = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                if (isReady)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .88,
                    child: PDFView(
                      filePath: widget.file.path,
                      autoSpacing: false,
                      pageFling: false,
                      onRender: (pages) {
                        pages = pages;
                        isReady = true;
                        setState(() {});
                      },
                      onError: print,
                      onPageError: (page, error) {
                        print('$page: $error');
                      },
                      gestureRecognizers: const <Factory<
                          OneSequenceGestureRecognizer>>{
                        Factory<OneSequenceGestureRecognizer>(
                          EagerGestureRecognizer.new,
                        ),
                      },
                      onViewCreated: _controller.complete,
                      onPageChanged: (int? page, int? total) {
                        print('page change: $page/$total');
                      },
                    ),
                  )
                else
                  const CircularProgressIndicator(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<File> createFileOfPdfUrl() async {
    final completer = Completer<File>();

    try {
      //read File
      final file = widget.file;
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
