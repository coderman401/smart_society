import "package:builders_group/src/l10n/app_localizations.dart";
import "package:builders_group/src/shared/widgets/app_carousel.dart";
import "package:flutter/material.dart";

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List data = [
    {"title": "visitors", "icon": Icons.person_4_outlined},
    {"title": "members", "icon": Icons.group_outlined},
    {"title": "notice_board", "icon": Icons.library_books_outlined},
    {"title": "amenities", "icon": Icons.sports_outlined},
    {"title": "services", "icon": Icons.cleaning_services_outlined},
    {"title": "parking", "icon": Icons.local_parking_outlined},
    {"title": "events", "icon": Icons.event_note_outlined},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List features =
        data
            .map(
              (f) => {
                "title": AppLocalizations.of(context).translate(f["title"]),
                "icon": f["icon"],
              },
            )
            .toList();

    return SafeArea(
      top: true,
      bottom: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: AppCarousel(
                items: [
                  "https://picsum.photos/1200/500?random=21",
                  "https://gingermediagroup.com/wp-content/uploads/2023/10/advertising.jpg",
                  "https://picsum.photos/1200/500?random=43",
                  "https://picsum.photos/1200/500?random=54",
                  "https://picsum.photos/1200/500?random=65",
                ],
                indicatorAlignment: IndicatorAlignment.CENTER,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(parent: ScrollPhysics()),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // number of items in each row
                mainAxisSpacing: 8.0, // spacing between rows
                crossAxisSpacing: 8.0, // spacing between columns
              ),
              itemCount: features.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return FeatureCard(
                  icon: features[index]["icon"],
                  title: features[index]["title"],
                  route: null,
                );
              },
            ),
            Container(
              height: 160,
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.lightGreen,
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.teal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context).translate("advertisement"),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? route;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Card(
        elevation: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Icon(icon, size: 48, color: Colors.blue),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
