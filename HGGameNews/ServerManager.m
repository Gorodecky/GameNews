//
//  ServerManager.m
//  HGGameNews
//
//  Created by Serg on 14.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"


@implementation ServerManager

+ (ServerManager*) sharedManager {
    
    static ServerManager* manager = nil;

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc]init];
    });
    return manager;
}

- (void) getNews:(void(^)(NSArray* rezultValue)) blockName
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
        [manager GET:@"http://gamenewsapp.ru:3000/api/news"
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, NSArray* responseObject) {
                 
            NSLog(@"JSON: %@", responseObject);
                 
                 if (responseObject) {
                     blockName(responseObject);
                 } else {
                     blockName (nil);
                 }
                 
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
            
            blockName (nil);
          
        }];

}

@end
