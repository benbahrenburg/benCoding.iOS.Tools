/**
 * Copyright (c) 2014 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */


/**
 *
 * Inspired by and modified from Harpy(https://github.com/ArtSabintsev/Harpy)
 *
 * Harpy is created by Arthur Ariel Sabintsev (http://www.sabintsev.com)
 *
 */

#import "BencodingIosToolsAppStoreHelpersProxy.h"


@implementation BencodingIosToolsAppStoreHelpersProxy

-(void)versionCheck :(id)args
{
    ENSURE_ARG_COUNT(args,2);
    ENSURE_UI_THREAD(versionCheck,args);
    
    NSString* appID = [TiUtils stringValue:[args objectAtIndex:0]];
	
    KrollCallback *callback = [args objectAtIndex:1];
	ENSURE_TYPE(callback,KrollCallback);
    
    if(callback == nil)
    {
        NSLog(@"Invalid callback function provided");
        return;
    }
    
    NSString * installedVersion =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    // Asynchronously query iTunes AppStore for publically available version
    NSString *storeString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", appID];
    NSURL *storeURL = [NSURL URLWithString:storeString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:storeURL];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if ( [data length] > 0 && !error ) { // Success
            
            
            NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{                
                
                // All versions that have been uploaded to the AppStore
                NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];
                
                
                if ( ![versionsInAppStore count] ) { // No versions of app in AppStore
                    
                    if (callback){
                        NSDictionary *errData = [NSDictionary dictionaryWithObjectsAndKeys:
                                                 NUMBOOL(NO),@"success",
                                                 @"no version information found",@"message",
                                                 [NSNumber numberWithInt:[@"404" intValue]], @"code",
                                                 installedVersion,@"installedVersion",
                                                 appID,@"appID",
                                                 nil];
                        
                        [self _fireEventToListener:@"storeQuery"
                                        withObject:errData listener:callback thisObject:nil];
                    }
                    
                } else {

                    NSString *currentAppStoreVersion = [versionsInAppStore objectAtIndex:0];

                    if (callback){
                        
                        NSDictionary *foundData = [NSDictionary dictionaryWithObjectsAndKeys:
                                                   NUMBOOL(YES),@"success",
                                                   [NSNumber numberWithInt:[@"200" intValue]], @"code",
                                                   installedVersion,@"installedVersion",
                                                   appID,@"appID",
                                                   currentAppStoreVersion,@"appStoreVersion",
                                                   nil];
                        
                        [self _fireEventToListener:@"storeQuery"
                                        withObject:foundData listener:callback thisObject:nil];

                    }
                }
                
            });
        }
        
    }];
        
}

-(void)launch:(id)arg
{
    ENSURE_ARG_COUNT(arg,1);
    ENSURE_UI_THREAD(launch,arg);
    
    NSString* appID = [TiUtils stringValue:[arg objectAtIndex:0]];
    
    NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", appID];
    NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
    [[UIApplication sharedApplication] openURL:iTunesURL];
    
}

@end
