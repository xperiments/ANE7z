//
//  ANELZMAExtractor.m
//  ANE7z
//
//  Created by Pedro Casaubon on 18/02/13.
//  Copyright (c) 2013 xperiments. All rights reserved.
//
#import "FlashRuntimeExtensions.h"
#import "ANELZMAExtractor.h"

int do7z_extract_entry(char *archivePath, char *archiveCachePath, char *entryName, char *entryPath);
int do7z_extract_entry_context(char *archivePath, char *archiveCachePath, char *entryName, char *entryPath, FREContext context);


@implementation ANELZMAExtractor


+ (NSString*) generateUniqueTmpCachePath
{
    NSString *tmpDir = NSTemporaryDirectory();
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval ti = [nowDate timeIntervalSinceReferenceDate];
    
    // Format number of seconds as a string with a decimal separator
    NSString *doubleString = [NSString stringWithFormat:@"%f", ti];
    
    // Remove the decimal point so that the file name consists of
    // numeric characters only.
    
    NSRange range;
    range = NSMakeRange(0, [doubleString length]);
    NSString *noDecimalString = [doubleString stringByReplacingOccurrencesOfString:@"."
                                                                        withString:@""
                                                                           options:0
                                                                             range:range];
    
    range = NSMakeRange(0, [noDecimalString length]);
    NSString *noMinusString = [noDecimalString stringByReplacingOccurrencesOfString:@"-"
                                                                         withString:@""
                                                                            options:0
                                                                              range:range];
    
    NSString *filename = [NSString stringWithFormat:@"%@%@", noMinusString, @".cache"];
    
    NSString *tmpPath = [tmpDir stringByAppendingPathComponent:filename];
    
    return tmpPath;
}


+ (void) extract7zArchive:(NSString*)archivePath
                    toDirName:(NSString*)toDirName
                    context:(FREContext)context
{

   [[NSFileManager defaultManager] changeCurrentDirectoryPath:toDirName];

    
    char *archivePathPtr = (char*) [archivePath UTF8String];
    NSString *archiveCachePath = [self generateUniqueTmpCachePath];
    char *archiveCachePathPtr = (char*) [archiveCachePath UTF8String];
    char *entryNamePtr = NULL; // Extract all entries by passing NULL
    char *entryPathPtr = NULL;
    
    
    if( context == NULL )
    {
        do7z_extract_entry(archivePathPtr, archiveCachePathPtr, entryNamePtr, entryPathPtr);
    }
    else
    {
        do7z_extract_entry_context(archivePathPtr, archiveCachePathPtr, entryNamePtr, entryPathPtr,context);
    }

}


+ (BOOL) extractArchiveEntry:(NSString*)archivePath
                archiveEntry:(NSString*)archiveEntry
                     outPath:(NSString*)outPath
                    
{
    
    char *archivePathPtr = (char*) [archivePath UTF8String];
    NSString *archiveCachePath = [self generateUniqueTmpCachePath];
    char *archiveCachePathPtr = (char*) [archiveCachePath UTF8String];
    char *archiveEntryPtr = (char*) [archiveEntry UTF8String];
    char *outPathPtr = (char*) [outPath UTF8String];
    
    int result = do7z_extract_entry(archivePathPtr, archiveCachePathPtr, archiveEntryPtr, outPathPtr);

    return (result == 0);
}

@end
