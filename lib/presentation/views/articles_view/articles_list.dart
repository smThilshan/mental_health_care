import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:mental_health/data/models/news_response_model.dart';
import 'package:mental_health/presentation/widgets/custom_button.dart';

class ArticlesList extends StatefulWidget {
  final List<ArticleModel> articleModels;
  const ArticlesList({Key? key, required this.articleModels}) : super(key: key);

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.articleModels.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.articleModels[index].author.toString(),
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.articleModels[index].title.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Use a conditional expression to check if urlToImage is empty or not
                  widget.articleModels[index].urlToImage != ''
                      ? Image.network(
                    widget.articleModels[index].urlToImage.toString(),
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      }
                    },
                  )
                      : Image.network(
                    'https://precisionpharmacy.net/wp-content/themes/apexclinic/images/no-image/No-Image-Found-400x264.png',
                  ),
                  Text(
                    widget.articleModels[index].description.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  CustomButtonWidget(
                    onPressed: () {
                      FlutterWebBrowser.openWebPage(
                        url: widget.articleModels[index].url.toString(),
                        customTabsOptions: CustomTabsOptions(
                          colorScheme: CustomTabsColorScheme.dark,
                          toolbarColor: Colors.deepPurple,
                          secondaryToolbarColor: Colors.green,
                          navigationBarColor: Colors.amber,
                          addDefaultShareMenuItem: true,
                          instantAppsEnabled: true,
                          showTitle: true,
                          urlBarHidingEnabled: true,
                        ),
                        safariVCOptions: SafariViewControllerOptions(
                          barCollapsingEnabled: true,
                          preferredBarTintColor: Colors.green,
                          preferredControlTintColor: Colors.amber,
                          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
                          modalPresentationCapturesStatusBarAppearance: true,
                        ),
                      );
                    },
                    text: 'Read Article',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
