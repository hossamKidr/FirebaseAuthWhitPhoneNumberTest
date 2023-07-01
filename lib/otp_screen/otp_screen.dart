import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:phone_auth_tist/cubit/auth_cubit.dart';
import 'package:phone_auth_tist/home_screen/home_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}
late String otpCode;
class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> AuthCubit(),
      child: BlocConsumer<AuthCubit,AuthState>(
        listener: (context,state){
          if(state is OTPSuccessState){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          }
          if(state is OtpErrorState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context,state){
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OtpTextField(
                      numberOfFields: 6,
                      showFieldAsBox: true,
                      mainAxisAlignment: MainAxisAlignment.center,
                      onSubmit: (otp){
                        otpCode = otp;
                      },
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child:state is OtpLoadingState?const Center(child: CircularProgressIndicator(),): ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.black87),
                          ),
                          onPressed: (){
                            BlocProvider.of<AuthCubit>(context).sendOTP(otpCode);
                          },
                          child: const Text("Verify",style: TextStyle(color: Colors.white),)
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      )
      );
  }
}
