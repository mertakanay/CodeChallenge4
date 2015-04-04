//
//  DogOwnerDownloader.h
//  Assessment4
//
//  Created by Mert Akanay on 4/3/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DogOwnerDownloader : NSObject

+(void)downloadReaders:(void (^)(NSArray *))complete;

@end
