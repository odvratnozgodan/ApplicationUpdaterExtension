package eu.amodo.extensions.applicationupdater;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

import eu.amodo.extensions.applicationupdater.functions.CheckForUpdateFunction;
import eu.amodo.extensions.applicationupdater.functions.DisposeFunction;
import eu.amodo.extensions.applicationupdater.functions.InitFunction;

import java.util.HashMap;
import java.util.Map;

public class ExtensionContext extends FREContext {

	public static final String TAG = "eu.amodo.extensions.applicationupdater.ExtensionContext";

	@Override
	public void dispose() {
		Log.d(TAG, "Context disposed.");
	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> functions = new HashMap<String, FREFunction>();

		functions.put("init", new InitFunction());
		functions.put("disposeExtension", new DisposeFunction());
		functions.put("checkForUpdate", new CheckForUpdateFunction());
		return functions;
	}
}
