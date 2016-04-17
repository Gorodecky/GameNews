//
//  ListNews.h
//  HGGameNews
//
//  Created by Serg on 14.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListNews : NSObject

@property (strong, nonatomic) NSArray* arrayListNews;
@property (strong, nonatomic) NSArray* arrayTopNews;
@property (strong, nonatomic) NSArray* arrayWithOutTopNews;



//масыв топив
//масыв простых новын

- (void) newsParse:(NSArray*) arrayNews;

@end
