import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'model_stream.dart';

class Stream extends StatefulWidget {
  const Stream({Key? key}) : super(key: key);

  @override
  _StreamState createState() => _StreamState();
}

const supabaseUrl = 'https://vonjmrysdwuoatfdhtpu.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZvbmptcnlzZHd1b2F0ZmRodHB1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDUyMjg4MjEsImV4cCI6MTk2MDgwNDgyMX0.tTQPjsUc5BFcFQOjfS2e-knEmMns8RjTCOZVty-1nGE';

final client = SupabaseClient(supabaseUrl, supabaseKey);

class _StreamState extends State<Stream> {
  List<ClassStream> challengeModelList = [];

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
                        challengeModelList = [];
                        for (var data in snapshot.data!) {
                          challengeModelList.add(ClassStream.fromJson(data));
                        }
                        return ListView.builder(
                          itemCount: challengeModelList.length,
                          itemBuilder: (BuildContext context, index) {
                            var teste =
                                challengeModelList[index].streamNome.toString();
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text(
                                  teste.substring(0, 1).toUpperCase(),
                                ),
                              ),
                              title: Text(
                                challengeModelList[index].streamNome.toString(),
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
