import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_tist/cubit/auth_cubit.dart';
import 'package:phone_auth_tist/otp_screen/otp_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}
final phoneController = TextEditingController();
class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>AuthCubit(),
      child:BlocConsumer<AuthCubit,AuthState>(
        listener: (context,state){
          if(state is AuthSuccessState){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const OtpScreen()));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.redAccent, content: Text("Successfully")));
          }
          if(state is AuthErrorState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.redAccent, content: Text(state.message)));
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black87,
              title: const Text('PhoneAuthTest'),
              centerTitle: true,
            ),
            body:  Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder:OutlineInputBorder(

                          ) ,
                          label: Text('enter uor phone number',style: TextStyle(color: Colors.black87),)
                      ),
                      controller:phoneController ,
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child:state is AuthLoadingState?const Center(child: CircularProgressIndicator(),): ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.black87),
                          ),
                          onPressed: (){
                            BlocProvider.of<AuthCubit>(context).authWithPhone(phoneController.text.trim());
                          },
                          child: const Text("Next",style: TextStyle(color: Colors.white),)
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ) ,
    );
  }
}
