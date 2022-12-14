import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vng_pilot/configs/models.dart';
import 'package:vng_pilot/configs/myclass.dart';
import 'package:vng_pilot/widgets/dialogs.dart';
import '../configs/api_service.dart';
import '../configs/colors.dart';
import '../configs/configs.dart';
import '../widgets/placeholder_imageview.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text('History', style: appBarTextStyle()),
          centerTitle: true,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    MyClass.isGridView = !MyClass.isGridView;
                  });
                },
                icon: Icon((MyClass.isGridView) ? Icons.view_agenda_outlined : Icons.grid_view_outlined))
          ],
        ),
        Expanded(
            child: FutureBuilder<HistoryResponse>(
          future: _fetchHistory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null && snapshot.data?.status == true) {
                return buildData(snapshot.data!);
              } else {
                return showErrorWidget(snapshot.data?.message);
              }
            } else if (snapshot.hasError) {
              return showErrorWidget(snapshot.error.toString());
            }
            return buildShimmer();
          },
        ))
      ],
    );
  }

  Widget buildShimmer() {
    return Shimmer.fromColors(
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighlightColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/vng_icon.png", height: 80, color: lineColor),
            SizedBox(height: 20),
            Text("Please wait...", style: TextStyle(fontSize: 20, color: lineColor),)
          ],
        ),
      )
    );
  }

  Widget buildData(HistoryResponse model) {
    if (MyClass.isGridView) {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: DynamicHeightGridView(
          physics: const BouncingScrollPhysics(),
          itemCount: model.documents?.length ?? 0,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          builder: (ctx, index) {
            return _buildGridItem(model.documents![index]);
          },
        ),
      );
    } else {
      return Material(
        color: Colors.white,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(15),
          itemCount: model.documents?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return _buildListItem(model.documents![index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 20);
          },
        ),
      );
    }
  }

  Widget _buildGridItem(HistoryModel model) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(WIDGET_RADIUS),
        border: Border.all(color: lineLightColor),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(WIDGET_RADIUS),
            child: PlaceHolderImage(
              image: model.image ?? "",
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    model.title ?? "-",
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(fontSize: 14, color: textDarkColor),
                  ),
                  SizedBox(height: 3),
                  Text(
                    formatDateTime(model.datetime ?? "-"),
                    style: TextStyle(fontSize: 12, color: textMidColor),
                  ),
                  Divider(
                    height: 15,
                    thickness: 0.5,
                    color: lineColor.withOpacity(0.5),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                        decoration: BoxDecoration(color: (model.isProcessed == true) ? successColor : textMidColor, borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          (model.isProcessed == true) ? "Ready" : "Pending",
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(fontSize: 11, letterSpacing: 0.5, color: Colors.white),
                        ),
                      ),
                      const Spacer(),
                      Text('View Details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: (model.isProcessed == true) ? linkColor : textLightColor))
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildListItem(HistoryModel model) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(WIDGET_RADIUS),
          child: PlaceHolderImage(
            image: model.image ?? "",
            width: 120,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 10),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              model.title ?? "-",
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: TextStyle(fontSize: 15, color: textDarkColor),
            ),
            SizedBox(height: 5),
            Text(
              formatDateTime(model.datetime ?? "-"),
              style: TextStyle(fontSize: 12, color: textMidColor),
            ),
            Divider(
              height: 15,
              thickness: 0.5,
              color: lineColor.withOpacity(0.5),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  decoration: BoxDecoration(color: (model.isProcessed == true) ? successColor : textMidColor, borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    (model.isProcessed == true) ? "Ready" : "Pending",
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: Colors.white),
                  ),
                ),
                const Spacer(),
                Text('View Details', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: (model.isProcessed == true) ? linkColor : textLightColor))
              ],
            )
          ],
        )),
      ],
    );
  }

  Future<HistoryResponse> _fetchHistory() async {
    late HistoryResponse _model;
    final apiService = ApiService.create();
    await apiService.getHistory(MyClass.userId).then((body) => _model = body).catchError((error) {
      _model = HistoryResponse(false, message: error.toString());
      return _model;
    });
    return _model;
  }
}
