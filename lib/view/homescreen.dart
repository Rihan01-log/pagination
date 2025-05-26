import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/controller/productcont.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Productcont>().getData();
    });

    pageController = PageController();
    pageController.addListener(() {
      final provider = context.read<Productcont>();
      if (pageController.page != null &&
          pageController.page!.round() ==
              (provider.products.length / 8).floor() &&
          !provider.isLoading &&
          provider.hasMore) {
        provider.getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product')),
      body: Consumer<Productcont>(
        builder: (context, value, child) {
          int totalPages = (value.products.length / 8).ceil();

          return PageView.builder(
            controller: pageController,
            itemCount: totalPages + (value.hasMore ? 1 : 0),
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * 8;
              if (startIndex >= value.products.length) {
                return const Center(child: Text('No more data'));
              }
              final endIndex = (startIndex + 8).clamp(0, value.products.length);
              final pageItems = value.products.sublist(startIndex, endIndex);

              if (pageItems.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: pageItems.length,
                  itemBuilder: (context, index) {
                    final product = pageItems[index];
                    return Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child:
                                product.thumbnail != null
                                    ? Image.network(
                                      product.thumbnail!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    )
                                    : Container(color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  product.title ?? 'No title',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                Text(
                                  'Price: ${product.price.toString()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  product.description!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
