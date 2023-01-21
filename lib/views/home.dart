import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:praujikom/models/doa.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ModelDoa> _list = [];
  final List<ModelDoa> _search = [];
  var loading = false;

  Future<dynamic> fetchDataDoa() async {
    _list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(Uri.parse('https://doa-doa-api-ahmadramadhan.fly.dev/api/'));
    if (response.statusCode == 200) {
      setState(() {
        var data = jsonDecode(response.body);
        for (Map<String, dynamic> i in data) {
          _list.add(ModelDoa.formJson(i));
          loading = false;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataDoa();
  }

  final TextEditingController _controllerSearch = TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    for (var element in _list) {
      if (element.doa.contains(text) || element.latin.contains(text)) {
        _search.add(element);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: const Color.fromARGB(255, 0, 0, 70),
                expandedHeight: 240,
                floating: true,
                pinned: true,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(top: 0, bottom: 15, left: 15, right: 15),
                  expandedTitleScale: 1.2,
                  centerTitle: true,
                  title: const Text(
                    'Doa-doa Sehari-hari',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  background: Stack(
                    children: [
                      Image(
                        image: const AssetImage('assets/images/5043393.jpg'),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  collapseMode: CollapseMode.parallax,
                ),
              ),
            ];
          },
          body: loading ? const Center(child: CircularProgressIndicator(),) : Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
                  child: Text(
                    'Berikut adalah doa-doa yang sering dibacakan dikehidupan sehari-hari. Sudah hafal belum??',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    leading: const Icon(Icons.search),
                    title: TextField(
                      controller: _controllerSearch,
                      onChanged: onSearch,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          _controllerSearch.clear();
                          onSearch('');
                        },
                        icon: const Icon(Icons.cancel)),
                  ),
                ),
                Expanded(
                  child: _search.isNotEmpty || _controllerSearch.text.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: _search.length,
                          itemBuilder: (context, index) {
                            final dataSearch = _search[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.only(bottom: 15),
                              elevation: 5,
                              child: Theme(
                                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  textColor: const Color.fromRGBO(15, 1, 120, 1),
                                  iconColor: const Color.fromRGBO(15, 1, 120, 1),
                                  title: Text(
                                    dataSearch.doa,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              dataSearch.ayat,
                                              textDirection: TextDirection.rtl,                                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              dataSearch.latin,
                                              textAlign: TextAlign.justify,
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              dataSearch.artinya,
                                              textAlign: TextAlign.justify,
                                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: _list.length,
                          itemBuilder: (BuildContext context, int index) {
                            var dataDoa = _list[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.only(bottom: 15),
                              elevation: 5,
                              child: Theme(
                                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  textColor: const Color.fromRGBO(15, 1, 120, 1),
                                  iconColor: const Color.fromRGBO(15, 1, 120, 1),
                                  title: Text(
                                    dataDoa.doa,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              dataDoa.ayat,
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              dataDoa.latin,
                                              textAlign: TextAlign.justify,
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              dataDoa.artinya,
                                              textAlign: TextAlign.justify,
                                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
