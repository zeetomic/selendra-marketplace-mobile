import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/screens/home/components/body.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: _buildAppBar(),
      drawer: HomeDrawer(),
    );
  }

  Widget _buildAppBar() {
    return SafeArea(
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool boxIsScroll) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              primary: true,
              forceElevated: boxIsScroll,
              brightness: Brightness.light,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: kDefaultColor,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              //backgroundColor: Colors.white,
              // leading: ReuseIconBadge(() {
              //   Scaffold.of(context).openDrawer();
              // }, Icons.menu, kDefaultColor, 25.0),
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    child: Image.asset('images/logo.png', width: 30, height: 30),
                    padding: EdgeInsets.only(right: 5)),
                  Text(
                    'SELENDRA',
                    style: TextStyle(
                      color: kDefaultColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: kDefaultColor,
                  ),
                  onPressed: () {
                    /*Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()));*/
                    showSearch(context: context, delegate: SearchProducts());
                  },
                ),
              ],
            ),
          ];
        },
        body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus.unfocus(),
            child: Body()),
      ),
    );
  }
}
