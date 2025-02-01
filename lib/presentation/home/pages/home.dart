import 'package:flutter/material.dart';
import 'package:groovroads/common/helpers/isdarkmode.dart';
import 'package:groovroads/common/widgets/appbar/appbar.dart';
import 'package:groovroads/core/configs/assets/appvectors.dart';
import 'package:groovroads/core/configs/theme/colors.dart';
import 'package:groovroads/presentation/home/widgets/newsongs.dart';
import 'package:groovroads/presentation/home/widgets/playlist.dart';
import 'package:groovroads/presentation/profile/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        hideBack: true,
        action: 
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const ProfilePage()));
          },
          icon: Icon(Icons.person
          ),
        ),
        title: Image.asset(
          Appvectors.logo,
          width: 100,
          height: 100,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            homeArtistCard(),
            SizedBox(height: 40),
            tabs(),
            SizedBox(height: 20,),
            SizedBox(
              height: 300,
              child: TabBarView(controller: tabController,
              children: [
                NewSongs(),
                Container(),
                Container(),
                Container(),
              ],),
            ),
            SizedBox(height: 20,),
            const PlayList(),
          ],
        ),
      ),
    );
  }

  Widget homeArtistCard() {
    return Center(
      child: Container(
        height: 150,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                Appvectors.topCard,
                width: 390,
                height: 200,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 40, bottom: 8.5),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    const Color.fromARGB(255, 199, 158, 37).withOpacity(1),
                    BlendMode.modulate,
                  ),
                  child: Image.asset(
                    Appvectors.musicPlayer,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabs() {
    return Container(
      color: Colors.transparent,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        indicatorColor: AppColors.primary,
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        tabs: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('News', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('TBA', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('TBA', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('TBA', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}