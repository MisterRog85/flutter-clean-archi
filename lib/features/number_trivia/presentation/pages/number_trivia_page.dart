import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_archi/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_clean_archi/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:flutter_clean_archi/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Number Trivia"),
      ),
      body: SingleChildScrollView(child: buildBody()),
    );
  }
}

class buildBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              //top half
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return MessageDisplay(message: "Start searching !",);
                    } else if (state is LoadingState) {
                      return LoadingWidget();
                    } else if (state is Loaded) {
                      return TriviaDisplay(numberTrivia: state.trivia,);
                    } else if (state is Error) {
                      return MessageDisplay(message: state.message,);
                    }
                    return MessageDisplay(message: "Nothing to show",);
                  }
              ),
              SizedBox(height: 20),
              //Bottom half
              TriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}

