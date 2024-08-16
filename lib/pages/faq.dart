import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fspmi/models/faq.dart';
import 'package:fspmi/shared/utils/dio.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List<FAQ> _daftarPertanyaan = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    final token = await storage.read(key: 'token');

    final response = await Request.get("/faq", headers: {
      'Authorization': 'Bearer $token',
    });

    List<FAQ> faq = [];

    for (var item in response['daftarFaq']) {
      faq.add(FAQ.fromJson(item));
    }

    setState(() {
      _daftarPertanyaan = faq;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Pertanyaan Umum",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 32),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _daftarPertanyaan[index].isExpanded = isExpanded;
                });
              },
              children: _daftarPertanyaan
                  .map<ExpansionPanel>((FAQ faq) => ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(faq.pertanyaan),
                          );
                        },
                        body: ListTile(
                          title: Text(faq.jawaban),
                        ),
                        isExpanded: faq.isExpanded,
                      ))
                  .toList(),
            )
        ],
      ),
    );
  }
}
