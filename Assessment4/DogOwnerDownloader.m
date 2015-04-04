//
//  DogOwnerDownloader.m
//  Assessment4
//
//  Created by Mert Akanay on 4/3/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "DogOwnerDownloader.h"

@implementation DogOwnerDownloader

+(void)downloadReaders:(void (^)(NSArray *))complete
{
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSArray *ownersArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        complete (ownersArray);
    }];
}

@end
