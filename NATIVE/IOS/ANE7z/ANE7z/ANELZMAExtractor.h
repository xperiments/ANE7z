//
//  ANELZMAExtractor.h
//  ANE7z
//
//  Created by Pedro Casaubon on 18/02/13.
//  Copyright (c) 2013 xperiments. All rights reserved.
//


@interface ANELZMAExtractor : NSObject

+ (NSString*) generateUniqueTmpCachePath;

+ (void) extract7zArchive:(NSString*)archivePath
                    toDirName:(NSString*)toDirName
                      context:(FREContext)context;

+ (BOOL) extractArchiveEntry:(NSString*)archivePath
                archiveEntry:(NSString*)archiveEntry
                     outPath:(NSString*)outPath;
@end
