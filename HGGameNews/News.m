//
//  News.m
//  HGGameNews
//
//  Created by Serg on 14.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "News.h"

@implementation News

- (id)initWithServerResponse:(NSDictionary*) responseObject {
    
    self = [super init];
    if (self) {
        
        self.newsName            = responseObject[@"name"];
        self.newsLink            = responseObject [@"link"];
        /*
        NSString* stringDate = responseObject[@"createdAt"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        
        self.newsDateOfCreating  = [dateFormatter dateFromString:stringDate];
        
        NSDate *date = [dateFormatter dateFromString:stringDate];
        NSLog(@"date = %@",date);
        
        
        
        */
        
        NSString *dateString = responseObject[@"createdAt"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        // voila!
        self.newsDateOfCreating = [dateFormatter dateFromString:dateString];
        
        
        
        self.newsPhotoUrl        = responseObject[@"cover"];
                
        self.newsTopMark         = [[responseObject objectForKey:@"top" ] boolValue];
       
        
        /*
        NSString* urlString = [responseObject objectForKey:@"photo_50"];
        
        if (urlString) {
            self.imageUrl = [NSURL URLWithString:urlString];
        */
        
        
    }
    return self;
}

@end
