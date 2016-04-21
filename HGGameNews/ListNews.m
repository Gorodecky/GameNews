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
    
    int i = 0;
    
    for (NSDictionary* dictionary in arrayNews) {
        
        i++;
        
        News* news = [[News alloc] initWithServerResponse:dictionary];
        
        if (i == 1 || i == 7 ||  i == 9)
        {
            news.newsTopMark = YES;
        }
        
        
        [array addObject:news];
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
