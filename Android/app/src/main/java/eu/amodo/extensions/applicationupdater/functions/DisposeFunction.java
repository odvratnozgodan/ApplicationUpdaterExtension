package eu.amodo.extensions.applicationupdater.functions;

import android.content.Context;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import eu.amodo.extensions.applicationupdater.ExtensionActivity;

public class DisposeFunction implements FREFunction {

	public static final String TAG = "eu.amodo.extensions.applicationupdater.functions.DisposeFunction";
	
	public FREObject call(FREContext context, FREObject[] args) {
		Log.i(TAG, "DisposeFunction()");
		Context appContext = ExtensionActivity.getInstance().appContext;
		return null;
	}

}
