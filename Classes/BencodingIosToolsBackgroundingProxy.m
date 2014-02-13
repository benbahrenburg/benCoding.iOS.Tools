/**
 * Copyright (c) 2014 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "BencodingIosToolsBackgroundingProxy.h"

@implementation BencodingIosToolsBackgroundingProxy

NSNumber *const BACKGROUND_STATUS_UNKNOWN = -1;
NSNumber *const BACKGROUND_STATUS_AVAILABLE = 0;
NSNumber *const BACKGROUND_STATUS_DENIED = 1;
NSNumber *const BACKGROUND_STATUS_RESTRICTED = 2;

-(NSNumber*)findBackgroundRefreshStatus:(id)unused
{
   
    if ([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusAvailable) {
        return BACKGROUND_STATUS_AVAILABLE;
        
    }
    
    if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied){
       return BACKGROUND_STATUS_DENIED;
        
    }
    
    if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted){
        return BACKGROUND_STATUS_RESTRICTED;
    }
    
    return BACKGROUND_STATUS_UNKNOWN;
}



MAKE_SYSTEM_PROP(STATUS_UNKNOWN, BACKGROUND_STATUS_UNKNOWN); //Unknown status
MAKE_SYSTEM_PROP(STATUS_AVAILABLE, BACKGROUND_STATUS_AVAILABLE); //UIBackgroundRefreshStatusAvailable
MAKE_SYSTEM_PROP(STATUS_DENIED, BACKGROUND_STATUS_DENIED); //UIBackgroundRefreshStatusDenied
MAKE_SYSTEM_PROP(STATUS_RESTRICTED, BACKGROUND_STATUS_RESTRICTED); //UIBackgroundRefreshStatusRestricted

@end
