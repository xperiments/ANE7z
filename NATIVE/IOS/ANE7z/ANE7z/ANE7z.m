//
//  ANE7z.m
//  ANE7z
//
//  Created by ANEBridgeCreator on 18/02/2013.
//  Copyright (c)2013 ANEBridgeCreator. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "FRETypeUtils.h"
#import "ANELZMAExtractor.h"
#import "ANE7zEventMessages.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
#define DISPATCH_STATUS_EVENT(extensionContext, code, status) FREDispatchStatusEventAsync((extensionContext), (uint8_t*)code, (uint8_t*)status)
#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }


/****************************************************************************************
 * @method:decompress( source:String,destination:String ):void
 ****************************************************************************************/
DEFINE_ANE_FUNCTION( decompress )
{

    NSString *source = nil;
    NSString *destination = nil;
    
    FREGetObjectAsString(argv[0], &source );
    FREGetObjectAsString(argv[1], &destination );
    
    [ANELZMAExtractor extract7zArchive:source toDirName:destination context:NULL ];
    return NULL;
    
}


/****************************************************************************************
 * @method:decompressAsync( source:String,destination:String ):void
 ****************************************************************************************/
DEFINE_ANE_FUNCTION( decompressAsync )
{
    
    NSString *source = nil;
    NSString *destination = nil;

    
    FREGetObjectAsString(argv[0], &source );
    FREGetObjectAsString(argv[1], &destination );
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        DISPATCH_STATUS_EVENT( context, UN7Z_START, (uint8_t*)"");
        [ANELZMAExtractor extract7zArchive:source toDirName:destination context:context];
        DISPATCH_STATUS_EVENT( context, UN7Z_END, (uint8_t*)"");
        
    });

    return NULL;
}


/****************************************************************************************
 * @method:extractEntry( source:String,destination:String,entry:String):Boolean
 ****************************************************************************************/
DEFINE_ANE_FUNCTION( extractEntry )
{
    
    NSString *source = nil;
    NSString *destination = nil;
    NSString *entry = nil;
    
    FREGetObjectAsString(argv[0], &source );
    FREGetObjectAsString(argv[1], &destination );
    FREGetObjectAsString(argv[2], &entry );
    
    //  return->as3 ( resultFromBoolean as Boolean );
    uint32_t resultFromBoolean= [ANELZMAExtractor extractArchiveEntry:source archiveEntry:entry outPath:destination ];
    FREObject ane_resultFromBoolean= nil;
    FRENewObjectFromBool(resultFromBoolean, &ane_resultFromBoolean);
    
    return ane_resultFromBoolean;
    
}


/****************************************************************************************
 * @method:extractEntryAsync( source:String,destination:String,entry:String):void
 ****************************************************************************************/
DEFINE_ANE_FUNCTION( extractEntryAsync )
{
    
    NSString *source = nil;
    NSString *destination = nil;
    NSString *entry = nil;
    
    FREGetObjectAsString(argv[0], &source );
    FREGetObjectAsString(argv[1], &destination );
    FREGetObjectAsString(argv[2], &entry );
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        DISPATCH_STATUS_EVENT( context, UN7Z_ENTRY_START, (uint8_t*)"");
        BOOL result = [ANELZMAExtractor extractArchiveEntry:source archiveEntry:entry outPath:destination];
        NSString *resultJSON = [NSString stringWithFormat:@"{\"success\":%@}", result == 0 ? @"false":@"true" ];
        DISPATCH_STATUS_EVENT( context, UN7Z_ENTRY_END, (uint8_t*)[resultJSON UTF8String]);
        
    });
    
    return NULL;
}


/****************************************************************************************
 *																						*
 *	EXTENSION & CONTEXT																	*
 *																						*
 ****************************************************************************************/

void ANE7zContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet )
{
    NSLog(@"Entering ANE7zContextInitializer()");
    static FRENamedFunction functionMap[] = {
        // METHODS
        MAP_FUNCTION( decompress, NULL ),
        MAP_FUNCTION( decompressAsync, NULL ),
        MAP_FUNCTION( extractEntry, NULL ),
        MAP_FUNCTION( extractEntryAsync, NULL )
    };
    *numFunctionsToSet = sizeof( functionMap ) / sizeof( FRENamedFunction );
    *functionsToSet = functionMap;
    NSLog(@"Exiting ANE7zContextInitializer()");
}
void ANE7zContextFinalizer( FREContext ctx )
{
    NSLog(@"Entering ANE7zContextFinalizer()");
    NSLog(@"Exiting ANE7zContextFinalizer()");
    return;
}
void ANE7zExtensionInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet )
{
    NSLog(@"Entering ANE7zExtensionInitializer()");
    extDataToSet = NULL;  // This example does not use any extension data.
    *ctxInitializerToSet = &ANE7zContextInitializer;
    *ctxFinalizerToSet = &ANE7zContextFinalizer;
}
void ANE7zExtensionFinalizer()
{
    NSLog(@"Entering ANE7zExtensionFinalizer()");
    return;
}
