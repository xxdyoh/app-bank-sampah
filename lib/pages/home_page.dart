import 'package:flutter/material.dart';
import 'package:skripsi/util/my_button.dart';
import 'package:skripsi/util/my_card.dart';
import 'package:skripsi/util/my_list_tile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Pagecontroller
  final _controller = PageController();
  List<dynamic> _beritaSampah = [];

  @override
  void initState() {
    super.initState();
    fetchBeritaSampah();
  }

  Future<void> fetchBeritaSampah() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://newsapi.org/v2/everything?q=sampah&from=2025-04-11&sortBy=publishedAt&apiKey=4845cb04971f48788e402a364ba27b7e'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _beritaSampah = data['articles'];
        });
        print(_beritaSampah);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.lightBlue[200],
        child: Icon(
          Icons.camera_alt_outlined,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home,
                    size: 32,
                    color: Colors.lightBlue[200],
                  ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.people,
                    size: 32,
                  )
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Sisisi Skripsi',
                          style: TextStyle(
                            fontFamily: 'KaushanScript',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // Cards
              _beritaSampah.isEmpty
                  ? const Expanded(child: Center(child: CircularProgressIndicator()))
                  : Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9, // Proporsional di semua ukuran
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: _beritaSampah.length,
                      itemBuilder: (context, index) {
                        final berita = _beritaSampah[index];
                        return MyCard(
                          title: berita['title'] ?? '',
                          imageUrl: berita['urlToImage'] ?? '',
                          source: berita['source']['name'] ?? '',
                          url: berita['url'] ?? '',
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: _beritaSampah.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.grey.shade800,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // 3 Buttons -> Send + Pay + Bills

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Send Button
                    MyButton(
                        iconImagePath: 'lib/icons/plastic-bottle.png',
                          buttonText: 'Botol Plastik'
                    ),

                    // Pay Button
                    MyButton(
                        iconImagePath: 'lib/icons/wine-bottles.png',
                        buttonText: 'Botol Kaca'
                    ),

                    // Bills Button
                    MyButton(
                        iconImagePath: 'lib/icons/paper.png',
                        buttonText: 'Buku/HVS'
                    ),

                    // Bills Button
                    MyButton(
                        iconImagePath: 'lib/icons/milk-products.png',
                        buttonText: 'Duplex'
                    ),
                  ],
                ),
              ),
            ],
          ),
      )
    );
  }
}
