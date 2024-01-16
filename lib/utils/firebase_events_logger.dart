import 'package:firebase_analytics/firebase_analytics.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;

//no argument needed
analyticsLoginEvent() async {
  await analytics.logLogin(loginMethod: "phone_number");
}

//no argument needed
analyticsLoginError(error) async {
  await analytics.logLogin(loginMethod: "login error $error");
}

analyticsPhoneVerificationEvent() async {
  await analytics.logEvent(name: "Phone Verification");
}

analyticsEmailVerificationEvent() async {
  await analytics.logEvent(name: "Email Verification");
}

analyticsBlockedUserEvent() async {
  await analytics.logEvent(name: "Blocked user login");
}

//no argument needed
analyticsSignupEvent() async {
  await analytics.logSignUp(signUpMethod: "Sign up button clicked");
}

//no argument needed
analyticsSignUpError(error) async {
  await analytics.logSignUp(signUpMethod: "Sign up error : $error");
}

//no argument needed
analyticsSignUpSuccess() async {
  await analytics.logSignUp(signUpMethod: "Sign up Success");
}

//no argument needed
analyticsPhoneOTPError(error) async {
  await analytics.logSignUp(signUpMethod: "Phone OTP error: $error");
}

//no argument needed
analyticsPhoneOTPSent() async {
  await analytics.logSignUp(signUpMethod: "Phone OTP send");
}

//no argument needed
analyticsLogOutEvent() async {
  await analytics.logEvent(name: "logout");
}

//no argument needed
analyticsEditProfileEvent() async {
  await analytics.logEvent(name: "profile_edited");
}

//no argument needed
analyticsCallClient() async {
  await analytics.logEvent(
      name: "call_client", parameters: {"call_button_clicked": "true"});
}

//argument can be on_going_tab, not_started_tab, requests_tab or completed_tab
analyticsJobsTabSelectionEvent({required String selectedTab}) async {
  await analytics.logEvent(
      name: "jobs_tab_selection",
      parameters: {"jobs_tab_selected": selectedTab});
}

// argument can be child_detail, accepted_job_detail, job_request, requested_job_detail
analyticsDetailViewEvent({required String openedScreen}) async {
  await analytics.logEvent(
      name: "detail_view", parameters: {"detail_screen_opened": openedScreen});
}

//argument can be home, jobs, or profile
analyticsBottomNavigationEvent({required String selectedTab}) async {
  await analytics.logEvent(
      name: "bottom_navigation",
      parameters: {"bottom_tab_selected": selectedTab});
}

//argument can prospective_tutor or authorized_tutor
analyticsUserTypeLogger({required String userType}) async {
  await analytics.setUserProperty(name: "user_type", value: userType);
}

// argument can be tutor_Id or client_Id
analyticsUserIdSetter({required String id}) async {
  await analytics.setUserId(id: id);
}

// argument can be job_accepted or job_declined
analyticsJobRequestAcceptance({required String requestAcceptance}) async {
  await analytics.logEvent(
      name: "events_on_job_request",
      parameters: {"job_request_acceptance": requestAcceptance});
}

// argument can be job_started or job_terminated
analyticsJobStatus({required String jobStatus}) async {
  await analytics.logEvent(
      name: "events_on_job_status", parameters: {"job_status": jobStatus});
}

// argument can be request_for_payment or payment_proof_Sent
analyticsPaymentStatus({required String paymentStatus}) async {
  await analytics.logEvent(
      name: "events_on_payment", parameters: {"payment_status": paymentStatus});
}

// argument can be new_log_addition or edit_existing_log
analyticsAttendanceLog({required String attendanceLogType}) async {
  await analytics.logEvent(
      name: "events_on_attendance_log",
      parameters: {"attendance_log_type": attendanceLogType});
}
