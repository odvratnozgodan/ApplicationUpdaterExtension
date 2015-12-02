# Application Updater ANE

This is a Adobe Native Extension. It's used to check for app updates from the application store. It supports Android and iOS.
Note that for the extension to work the app has to be distributed and published to the Android and Apple app stores beforehand.


## Used external libraries
### Android
https://github.com/rampo/UpdateChecker

### iOS
https://github.com/ArtSabintsev/Harpy


## Usage
1. Add the extension to your project. You have to add the following permissions to the Android part of the Application-app.xml.
```
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```
2. Add initialized event listener and try to initialize the extension 
```
ApplicationUpdaterExtension.instance.addEventListener(ApplicationUpdaterEvent.INITIALIZED, initialized_Handler);
ApplicationUpdaterExtension.initialize();
```
3. If the platform is iOS you have to pass the AppStore app ID to the extension, otherwise the extension will not work. This step can be skipped for Android.
```
ApplicationUpdaterExtension.iOSAppID = "123456"
```
4. Call the check for update methods
	* `ApplicationUpdaterExtension.checkForUpdate();` - checks for update immediately(Android and iOS)
	* `ApplicationUpdaterExtension.checkForUpdateDaily();` - checks for update daily(iOS only)
	* `ApplicationUpdaterExtension.checkForUpdateWeekly();` - checks for update weekly(iOS only)
	

You are welcomed to use the extension and report issues, but I don't guarantee when will I have time to resolve any of them.
I will not be adding any features in the near future because for my use-case this extension is good enough.
 
##Pull requests welcome
I welcome anyone who wishes to fork the project and implement new features. In that case just create a pull request.  