import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/landing_widget.dart';
import '../widgets/user_data_widget.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: state is GetUserSuccessfully
              ? ListView(
                  children: [
                    const LandingWidget(
                      title: "Clean Architecture",
                    ),
                    UserData(user: state.user),
                    const CustomSearchBar(),
                  ],
                )
              : state is GetUserFailure
                  ? Center(child: Text(state.errMessage))
                  : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
