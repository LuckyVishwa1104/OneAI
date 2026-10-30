
// add this in signup view model's google sign up method for firebase id token clip-board printing

if (user != null) {
        debugPrint('Google Sign-In successful');
        debugPrint('UID: ${user.uid}');
        debugPrint('Email: ${user.email}');
        debugPrint('Name: ${user.displayName}');
        final String? idToken = await user.getIdToken(true);
        await Clipboard.setData(ClipboardData(text: idToken!));
        if (idToken != null) {
          debugPrint('Firebase ID Token length: ${idToken.length}');
          debugPrint('JWT segments: ${idToken.split('.').length}');
          debugPrint('JWT starts with eyJ: ${idToken.startsWith('eyJ')}');
        } else {
          debugPrint('Firebase ID Token is null');
        }
        debugPrint('Firebase ID Token: $idToken');
        await navigationService.clearStackAndShow(Routes.homeView);
      }
