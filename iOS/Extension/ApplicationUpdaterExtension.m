//////////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2012 Freshplanet (http://freshplanet.com | opensource@freshplanet.com)
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//    http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  
//////////////////////////////////////////////////////////////////////////////////////

#import "ApplicationUpdaterExtension.h"
#import "Harpy/Harpy.h"

FREContext ExtensionCtx = nil;


@implementation ApplicationUpdater

#pragma mark - Singleton

static ApplicationUpdater *sharedInstance = nil;

+ (ApplicationUpdater *)sharedInstance
{
    if (sharedInstance == nil)
    {
        sharedInstance = [[super allocWithZone:NULL] init];
    }

    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return self;
}

-(void)sendMessage:(NSString *)returnString{
    NSString *eventName = @"message";
    const uint8_t* messageCode = (const uint8_t*) [returnString UTF8String];
    const uint8_t* eventCode = (const uint8_t*) [eventName UTF8String];
    FREDispatchStatusEventAsync(ExtensionCtx, eventCode, messageCode);
}

@end


#pragma mark - C interface

/* This is a TEST function that is being included as part of this template. 
 *
 * Users of this template are expected to change this and add similar functions 
 * to be able to call the native functions in the ANE from their ActionScript code
 */

DEFINE_ANE_FUNCTION(initApplicationUpdaterExtension)
{
    NSLog(@"iOS >> initApplicationUpdaterExtension()");
    
    NSString *eventName = @"appReady";
    NSString *returnString = @"";
    const uint8_t* messageCode = (const uint8_t*) [returnString UTF8String];
    const uint8_t* eventCode = (const uint8_t*) [eventName UTF8String];
    FREDispatchStatusEventAsync(ExtensionCtx, eventCode, messageCode);
    
    return NULL;
}

DEFINE_ANE_FUNCTION(checkForUpdate)
{
    NSLog(@"iOS >> checkForUpdate()");
    uint32_t stringLength;
    const uint8_t *string;
    FREGetObjectAsUTF8(argv[0], &stringLength, &string);
    NSString *appID = [NSString stringWithUTF8String:(char*)string];
    
    UIWindow* keyWindow = [[UIApplication sharedApplication]keyWindow];
    UIViewController* mainController = [keyWindow rootViewController];
    
    // Present Window before calling Harpy
    //[self.window makeKeyAndVisible];
    
    // Set the App ID for your app
    [[Harpy sharedInstance] setAppID:appID];
    
    // Set the UIViewController that will present an instance of UIAlertController
    [[Harpy sharedInstance] setPresentingViewController:mainController];
    
    [[Harpy sharedInstance] checkVersion];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(checkForUpdateDaily)
{
    NSLog(@"iOS >> checkForUpdateDaily()");
    uint32_t stringLength;
    const uint8_t *string;
    FREGetObjectAsUTF8(argv[0], &stringLength, &string);
    NSString *appID = [NSString stringWithUTF8String:(char*)string];
    
    UIWindow* keyWindow = [[UIApplication sharedApplication]keyWindow];
    UIViewController* mainController = [keyWindow rootViewController];
    
    // Present Window before calling Harpy
    //[self.window makeKeyAndVisible];
    
    // Set the App ID for your app
    [[Harpy sharedInstance] setAppID:appID];
    
    // Set the UIViewController that will present an instance of UIAlertController
    [[Harpy sharedInstance] setPresentingViewController:mainController];
    
    [[Harpy sharedInstance] checkVersionDaily];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(checkForUpdateWeekly)
{
    NSLog(@"iOS >> checkForUpdateWeekly()");
    uint32_t stringLength;
    const uint8_t *string;
    FREGetObjectAsUTF8(argv[0], &stringLength, &string);
    NSString *appID = [NSString stringWithUTF8String:(char*)string];
    
    UIWindow* keyWindow = [[UIApplication sharedApplication]keyWindow];
    UIViewController* mainController = [keyWindow rootViewController];
    
    // Present Window before calling Harpy
    //[self.window makeKeyAndVisible];
    
    // Set the App ID for your app
    [[Harpy sharedInstance] setAppID:appID];
    
    // Set the UIViewController that will present an instance of UIAlertController
    [[Harpy sharedInstance] setPresentingViewController:mainController];
    
    [[Harpy sharedInstance] checkVersionWeekly];
    
    return NULL;
}

#pragma mark - ANE setup

/* ExtensionExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml 
 */
void ApplicationUpdaterExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) 
{
    NSLog(@"Entering ExtensionExtInitializer()");

    *extDataToSet = NULL;
    *ctxInitializerToSet = &ApplicationUpdaterContextInitializer;
    *ctxFinalizerToSet = &ApplicationUpdaterContextFinalizer;

    NSLog(@"Exiting ExtensionExtInitializer()");
}

/* ExtensionExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml 
 */
void ApplicationUpdaterExtFinalizer(void* extData) 
{
    NSLog(@"Entering ExtensionExtFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting ExtensionExtFinalizer()");
    return;
}

/* ContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
 */
void ApplicationUpdaterContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    NSLog(@"Entering ContextInitializer()");

    ExtensionCtx = ctx;
    
    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
     * As a sample, the function isSupported is being provided.
     */
    *numFunctionsToTest = 4;

    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    
    func[0].name = (const uint8_t*) "init";
    func[0].functionData = NULL;
    func[0].function = &initApplicationUpdaterExtension;
    
    func[1].name = (const uint8_t*) "checkForUpdate";
    func[1].functionData = NULL;
    func[1].function = &checkForUpdate;
    
    func[2].name = (const uint8_t*) "checkForUpdateDaily";
    func[2].functionData = NULL;
    func[2].function = &checkForUpdateDaily;
    
    func[3].name = (const uint8_t*) "checkForUpdateWeekly";
    func[3].functionData = NULL;
    func[3].function = &checkForUpdateWeekly;
    
    *functionsToSet = func;

    NSLog(@"Exiting ContextInitializer()");
}

/* ContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void ApplicationUpdaterContextFinalizer(FREContext ctx) 
{
    NSLog(@"Entering ContextFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting ContextFinalizer()");
    return;
}



