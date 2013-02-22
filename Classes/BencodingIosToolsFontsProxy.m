/**
 * Copyright (c) 2009-2013 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "BencodingIosToolsFontsProxy.h"

@implementation BencodingIosToolsFontsProxy

-(NSArray*) listSystemFonts:(id)callback
{
    NSMutableArray *results = [[NSMutableArray alloc] init];

    
    // Enumerate the installed font family names
    [[UIFont familyNames] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        NSString *fontFamily =(NSString *)obj;
        NSLog(@"\nFamily: %@", fontFamily);
 
        //NSMutableArray *familyFonts = [[NSMutableArray alloc] init];
        
        // Enumerate the font names in the each family
        [[UIFont fontNamesForFamilyName:fontFamily] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
//             debug(@"\tFont: %@\n", obj);
         }];
//        
//        NSDictionary *fontFamilyInfo = [NSDictionary dictionaryWithObjectsAndKeys:
//                                        fontFamily,@"fontFamily",
//                                        familyFonts,@"fonts",
//                                        nil];
        
    }];
}

@end
