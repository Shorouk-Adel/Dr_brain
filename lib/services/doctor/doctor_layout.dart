import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'doctor_cubit.dart';
import 'doctor_states.dart';

class DoctorLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(BuildContext context) => DoctorCubit(),
        child: BlocConsumer<DoctorCubit,DoctorStates>(
            listener:(context,state){} ,
            builder: (context,state) {
              DoctorCubit cubit = DoctorCubit.get(context);
              return Scaffold(
                body: cubit.MainScreens[cubit.currentIndex],

                bottomNavigationBar: BottomNavigationBar(

                  unselectedItemColor: Colors.black54,
                  selectedItemColor: Colors.deepPurple,
                  elevation: 20.0,
                  items:
                  cubit.bottomItems,
                  currentIndex: cubit.currentIndex,
                  onTap: (index){
                    cubit.changeIndex(index);
                  },


                ),

              );
            }));
  }
}
