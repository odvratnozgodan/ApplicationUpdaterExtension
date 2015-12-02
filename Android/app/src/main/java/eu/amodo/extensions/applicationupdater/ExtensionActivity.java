package eu.amodo.extensions.applicationupdater;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.rampo.updatechecker.UpdateChecker;
import com.rampo.updatechecker.UpdateCheckerResult;

public class ExtensionActivity extends Activity implements FREExtension {

	public final static String MAIN_ACTIVITY_CLASS_NAME_KEY = "eu.amodo.extensions.applicationupdater.mainActivityClassNameKey";

	public static final String TAG = "eu.amodo.extensions.applicationupdater.ExtensionActivity";
	public static FREContext extensionContext;
	public static Context appContext;
	public static String activityClassName;


	public static boolean disposeOnCloseService = false;

	private static ExtensionActivity instance = null;

    // The initialization method. This is the first method to be called.
	public void initialize() {
		Log.i(TAG, "initialize()");
		instance = this;
	}

	// This is the second method to be called.
	public FREContext createContext(String contextType) {
		Log.i(TAG, "createContext()");
		extensionContext = new ExtensionContext();
		return extensionContext;
	}

	public void dispose() {
		Log.i(TAG, "dispose()");
	}

	public void checkForUpdate(){
		Log.i(TAG, "checkForUpdate()");
        try{
            UpdateChecker checker = new UpdateChecker(extensionContext.getActivity());
            UpdateChecker.setSuccessfulChecksRequired(5);
            UpdateChecker.start();
        }catch (Exception otherException){
            otherException.printStackTrace();
            Log.d(TAG, "Exception - cannot start UpdateChecker");
        }
	}

	public static ExtensionActivity getInstance() {
		return instance;
	}

	public static void sendMessage(String str) {
		String eventName = "message";
		if (ExtensionActivity.extensionContext != null) {
			ExtensionActivity.extensionContext.dispatchStatusEventAsync(eventName, str);
		}
	}

	public static void notifyAppReady() {
		Log.i(TAG, "notifyAppReady()");
		String eventName = "appReady";
		ExtensionActivity.extensionContext.dispatchStatusEventAsync(eventName, "");
	}

}
