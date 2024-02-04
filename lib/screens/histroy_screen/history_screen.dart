
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/snackbar.dart';
import '../../logic/history_bloc/history_bloc.dart';

class HistroyScreen extends StatefulWidget {
  const HistroyScreen({Key? key}) : super(key: key);

  @override
  State<HistroyScreen> createState() => _HistroyScreenState();
}

class _HistroyScreenState extends State<HistroyScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(GetHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Fetch History",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
        ),
        centerTitle: true,
        leading: const Image(
          height: 100,
          width: 200,
          image: AssetImage("assets/dog.png"),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<HistoryBloc, HistoryBlocState>(
            builder: (context, state) {
              return state.dogList!.isEmpty
                  ? const Center(
                      child: Text(
                        "No History To Show",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.separated(
                      itemCount: state.dogList!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        color: Colors.grey,
                        height: 2,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.white,
                            leading: Container(
                              height: 200,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(state.dogList![index])),
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                context.read<HistoryBloc>().add(
                                      DeleteHistory(index: index),
                                    );

                                showSnackbar(
                                    context,
                                    "Removed  dog from history ",
                                    const Color.fromARGB(255, 236, 103, 94));
                              },
                              child: const Icon(Icons.delete),
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
