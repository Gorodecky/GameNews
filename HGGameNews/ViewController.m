//
//  ViewController.m
//  HGGameNews
//
//  Created by Serg on 13.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "ViewController.h"
#import "ServerManager.h"
#import "ListNews.h"

@interface ViewController ()
{
    ListNews* listNews;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ServerManager sharedManager] getNews:^(NSArray *rezultValue) {
        if (rezultValue == nil) {
            // Вывести алерт
        } else {
            
            listNews = [[ListNews alloc] init];
            
            [listNews newsParse:rezultValue];
            
            listNews.arrayListNews;
            
        }
        
    }];
}

    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
