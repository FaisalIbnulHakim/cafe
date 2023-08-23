import 'package:flutter/material.dart';
import 'package:cafe_flutter/food/food.dart';
import 'package:cafe_flutter/drink/drink.dart';
import 'package:cafe_flutter/dessert/dessert.dart';
import 'package:cafe_flutter/pages/bottom_nav.dart';

class ImageItem {
  final String urlImage;

  const ImageItem({
    required this.urlImage,
  });
}

class CardItem {
  final String url;
  final String name;
  final String sub;
  final Widget page;

  CardItem({
    required this.url,
    required this.name,
    required this.sub,
    required this.page,
  });
}

List<ImageItem> items = [
  ImageItem(
    urlImage:
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
  ),
  ImageItem(
    urlImage:
        'https://images.unsplash.com/photo-1565958011703-44f9829ba187?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=465&q=80',
  ),
  ImageItem(
    urlImage:
        'https://images.unsplash.com/photo-1556679343-c7306c1976bc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=464&q=80',
  ),
];

List<CardItem> cards = [
  CardItem(
    url:
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGZvb2R8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=1000&q=60',
    name: "Food",
    sub: "Variety Of High Quality Foods",
    page: Food(),
  ),
  CardItem(
    url:
        'https://images.unsplash.com/photo-1563729784474-d77dbb933a9e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
    name: "Dessert",
    sub: "Great dessert When Finished With The Meal",
    page: Dessert(),
  ),
  CardItem(
    url:
        'https://images.unsplash.com/photo-1534353473418-4cfa6c56fd38?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
    name: "Drink",
    sub: "A Delicious Drink To Relieve Thirst",
    page: Drink(),
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    // CartPage(),
    // ProfilePage(),
  ];

  void _onTabTapped(int index) {
    if (index == 0) {
      setState(() {
        _currentIndex = index;
      });
      if (index == 0) {
        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fiuls Cafe"),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 225, 225, 225),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  separatorBuilder: (context, _) => SizedBox(width: 12),
                  itemBuilder: (context, index) =>
                      buildImage(item: items[index]),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 30, left: 20),
                child: Text(
                  "Menu Categories",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25, left: 20, right: 20),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true, // Added shrinkWrap property
                  physics: NeverScrollableScrollPhysics(), // Disabled scrolling
                  itemCount: cards.length,
                  separatorBuilder: (context, _) => SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      buildCard(item: cards[index]),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  Widget buildImage({
    required ImageItem item,
  }) =>
      Container(
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            item.urlImage,
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget buildCard({
    required CardItem item,
  }) =>
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                item.url,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item.sub,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return item.page;
                        },
                      ),
                    );
                  },
                  child: Icon(
                    Icons.arrow_forward_outlined,
                    size: 30,
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(40, 40),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: -2, vertical: -4),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue.shade500,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      );
}
