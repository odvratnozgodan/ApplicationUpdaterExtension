package eu.amodo.extensions.applicationupdater.functions;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import eu.amodo.extensions.applicationupdater.ExtensionActivity;

public class CheckForUpdateFunction implements FREFunction {

	public static final String TAG = "eu.amodo.extensions.applicationupdater.functions.CheckForUpdateFunction";
	
	public FREObject call(FREContext context, FREObject[] args) {
		Log.i(TAG, "CheckForUpdateFunction()");
        int requiredChecks = 5;
        try {
            requiredChecks = args[0].getAsInt();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

		ExtensionActivity.getInstance().checkForUpdate(requiredChecks);
		return null;
	}

}
