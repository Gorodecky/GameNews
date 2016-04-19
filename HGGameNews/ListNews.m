//
//  ListNews.m
//  HGGameNews
//
//  Created by Serg on 14.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "ListNews.h"
#import "News.h"

@implementation ListNews

- (void) newsParse:(NSArray*) arrayNews {
    
    NSMutableArray * array = [NSMutableArray array];
    
    for (NSDictionary* dictionary in arrayNews) {
        
        [array addObject:[[News alloc] initWithServerResponse:dictionary]];
    }
    
    _arrayListNews = array;
    
    NSMutableArray* arrayTopNews = [NSMutableArray array];
    
    NSMutableArray* arrayWithOutTopNews = [NSMutableArray array];
    
    for (News* news in _arrayListNews) {
        
        if (news.newsTopMark == YES) {
            
            [arrayTopNews addObject:news];
            
        } else {
            
            [arrayWithOutTopNews addObject:news];
        }
    }
    _arrayTopNews = arrayTopNews;
    
    _arrayWithOutTopNews = arrayWithOutTopNews;
    
    if (_arrayTopNews > 0) {
        
        _availableTopNews = YES;
    }
}

- (NSArray*) searchNews:(NSString*)searchInformation {
    
    if (!searchInformation) {
        
        return _arrayListNews;
        
    } else {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(newsName contains[c] %@)",searchInformation];
        NSArray *filteredArray = [_arrayListNews filteredArrayUsingPredicate:predicate];
        return filteredArray;
    }
    return nil;
}

@end
