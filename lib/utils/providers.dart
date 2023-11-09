import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahasainik_app/bloc/best_selling/best_selling_bloc.dart';
import 'package:mahasainik_app/bloc/homescreen_search/search_bloc.dart';
import 'package:mahasainik_app/bloc/nearby_stores/nearby_stores_bloc.dart';
import 'package:mahasainik_app/bloc/products/products_bloc.dart';
import 'package:mahasainik_app/bloc/profile/profile_bloc.dart';
import 'package:mahasainik_app/bloc/send_otp/login_bloc.dart';
import 'package:mahasainik_app/bloc/verify_otp/verify_otp_bloc.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<BestSellingBloc>(
          create: (context) => BestSellingBloc(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<NearbyStoresBloc>(
          create: (context) => NearbyStoresBloc(),
        ),
        BlocProvider<ProductsBloc>(
          create: (context) => ProductsBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<VerifyOtpBloc>(
          create: (context) => VerifyOtpBloc(),
        ),
      ],
      child: child,
    );
  }
}
