import 'package:chat_room/zego/zego_constants.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallService {
  /// on App's user login
  void onUserLogin(String id,String userName) {
    /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: ZegoConstants.appID/*input your AppID*/,
      appSign: ZegoConstants.appSign /*input your AppSign*/,
      userID: id,
      userName: userName,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }

  /// on App's user logout
  void onUserLogout() {
    /// 1.2.2. de-initialization ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged out
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }
}
