import 'package:flutter/material.dart';
import 'package:storily/screens/dashboard/data/model/audiobook_model.dart';

class BookScreenWidget extends StatefulWidget {
  const BookScreenWidget({Key? key, required this.bookData}) : super(key: key);
  final AudioBookModel bookData;
  @override
  State<BookScreenWidget> createState() => _BookScreenWidgetState();
}

class _BookScreenWidgetState extends State<BookScreenWidget> {
  late PageController controller;
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          bottom: 24,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              widget.bookData.title ?? "",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Proxima Nova Bold'),
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
               "Page : $pageIndex / ${widget.bookData.pageUrl.length}",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Proxima Nova Bold'),
            ),
          ),
        ),
        PageView(
          controller: controller,
          onPageChanged: (value) {
            setState(() {
              pageIndex = (value + 1);
            });
          },
          children: widget.bookData.pageUrl
              .map(
                (imageLink) => Image.network(
                  imageLink!,
                  loadingBuilder: (context, child, loadingProgress) =>
                      (loadingProgress != null)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : child,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
