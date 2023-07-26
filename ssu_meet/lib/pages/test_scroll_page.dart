import 'package:flutter/material.dart';

class InfiniteScrollDemo extends StatefulWidget {
  const InfiniteScrollDemo({super.key});

  @override
  _InfiniteScrollDemoState createState() => _InfiniteScrollDemoState();
}

class _InfiniteScrollDemoState extends State<InfiniteScrollDemo> {
  List<String> dataList = [];
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int page = 1; // Initial page number

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }

  Future<void> _fetchData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      // Simulate an API request delay
      await Future.delayed(const Duration(seconds: 2));

      // Replace this with your actual API request to fetch the next batch of data
      List<String> newData =
          List.generate(20, (index) => 'Item ${dataList.length + index + 1}');

      setState(() {
        dataList.addAll(newData);
        page++; // Increment the page number for the next API request
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Scrolling Demo'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: dataList.length + 1, // Add 1 for the loading indicator
        itemBuilder: (context, index) {
          if (index < dataList.length) {
            return ListTile(
              title: Text(dataList[index]),
            );
          } else {
            return _buildLoadingIndicator();
          }
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
