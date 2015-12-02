package eu.amodo.extensions.applicationupdater.functions;

import android.content.Context;
import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import eu.amodo.extensions.applicationupdater.ExtensionActivity;

public class InitFunction implements FREFunction {
	public static final String TAG = "eu.amodo.extensions.applicationupdater.functions.InitFunction";
	
	public FREObject call(FREContext context, FREObject[] args) {
		Log.i(TAG, "InitFunction()");
//		ExtensionActivity.extensionContext = context;
		
		Log.i(TAG, "ExtensionActivity.getInstance().extensionContext: " + ExtensionActivity.getInstance().extensionContext);
		Context appContext = context.getActivity().getApplicationContext();
		ExtensionActivity.getInstance().appContext = appContext;
		
		ExtensionActivity.getInstance().activityClassName = context.getActivity().getClass().getName();
        ExtensionActivity.notifyAppReady();
	    return null;
	}
}
