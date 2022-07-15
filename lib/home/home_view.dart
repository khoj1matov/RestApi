import 'package:flutter/material.dart';
import 'package:restapi/models/api_model.dart';
import 'package:restapi/service/api_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    pageState();
  }

  void pageState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: FutureBuilder(
        future: ApiService.getData(),
        builder: (context, AsyncSnapshot<List<ApiModel>> snap) {
          if (!snap.hasData) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snap.hasError) {
            return const Center(
              child: Text("NO INTERNET !!!"),
            );
          } else {
            var data = snap.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                    itemBuilder: (_, __) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(data[__].id.toString()),
                        ),
                        title: Text(data[__].name!),
                        subtitle: Text(data[__].description!),
                        trailing: Text(data[__].price.toString()),
                      );
                    },
                    itemCount: snap.data!.length,
                  ),
                ),
                ElevatedButton(
                  child: const Text("Delete"),
                  onPressed: () {
                    ApiService.deleteData(data[data.length - 1].id.toString());
                    pageState();
                  },
                )
              ],
            );
          }
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: const Text(
        "Rest API",
        style: TextStyle(
          fontSize: 25,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
