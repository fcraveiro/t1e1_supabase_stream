import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'model_stream.dart';

class Stream extends StatefulWidget {
  const Stream({Key? key}) : super(key: key);

  @override
  _StreamState createState() => _StreamState();
}

const supabaseUrl = '';
const supabaseKey = '';

final client = SupabaseClient(supabaseUrl, supabaseKey);

class _StreamState extends State<Stream> {
  List<ClassStream> lista = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Mensagens'),
        centerTitle: true,
        backgroundColor: const Color(0xFF48426D),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 0,
              ),
              Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                    stream: client
                        .from('aula')
                        .stream(['streamUuId'])
                        .order('streamData', ascending: false)
                        .execute()
                        .handleError((e) => {
                              log('erro $e'),
                            }),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Text('Erro');
                      } else {
                        lista = [];
                        for (var data in snapshot.data!) {
                          lista.add(ClassStream.fromJson(data));
                        }
                        return ListView.builder(
                          itemCount: lista.length,
                          itemBuilder: (BuildContext context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text(
                                  lista[index]
                                      .streamNome
                                      .toString()
                                      .substring(0, 1)
                                      .toUpperCase(),
                                ),
                              ),
                              title: Text(
                                lista[index].streamNome.toString(),
                              ),
                              trailing: const Icon(Icons.mail),
                            );
                          },
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
