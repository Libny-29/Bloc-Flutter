import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/home/cubit/home_cubit.dart';
import 'package:gif_repository/gif_repository.dart';

class HomePege extends StatelessWidget {
  const HomePege({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(context.read<GifRepository>())..getData(),
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hola Libny :)"),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            switch(state.status){ 
              case HomeStatus.loading:
                return const  Center(child: CircularProgressIndicator());
                
              case HomeStatus.success:
                 return  GridView.count(
                  crossAxisCount: 2, 
                  children: 
                  state.gifs.map((gif) => Image.network(gif.url, fit: BoxFit.cover,)).toList(),
                 );
                
              case HomeStatus.error:
                return const Center(child:Text("Error"));
                
            }
           },
        ));
  }
}
