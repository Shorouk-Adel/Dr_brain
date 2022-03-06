import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_dr_brain/services/patient/patient_cubit.dart';
import 'package:graduation_dr_brain/services/patient/patient_states.dart';


class PatientLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(BuildContext context) => PatientCubit(),
        child: BlocConsumer<PatientCubit,PatientStates>(
            listener:(context,state){} ,
            builder: (context,state) {
              PatientCubit cubit = PatientCubit.get(context);
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
