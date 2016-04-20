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
#import "News.h"
#import "TopTableViewCell.h"
#import "TableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

{
    ListNews*    listNews;
    
    BOOL         searchMode;
    
    NSString*    searchText;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    searchMode = NO;
    
    [self showSearchBar];
    
    [self.searchBar setReturnKeyType:UIReturnKeyDone];
    
    //topCell Xib
    UINib *topNib = [UINib nibWithNibName:@"TopTableViewCell" bundle:nil];
    
    [[self tableView] registerNib:topNib forCellReuseIdentifier:topTableViewCellIdentifier];
    
    //standartCell Xib
    
    UINib * standartNib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    
    //NSString* standartNewsTableViewCellIdentifier = @"standartCell";
    
    [[self tableView] registerNib:standartNib forCellReuseIdentifier:standartTableViewCellIdentifier];
    
    //.........................
    
    [[ServerManager sharedManager] getNews:^(NSArray *rezultValue) {
        if (rezultValue == nil) {
            // Вывести алерт
        } else {
            
            listNews = [[ListNews alloc] init];
            
            [listNews newsParse:rezultValue];
            
            [self.tableView reloadData];
            // listNews.arrayListNews;
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (IBAction)onSearch:(id)sender {
    if (searchMode) {
        
        _searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                      target:self
                                                                      action:@selector(onSearch:)];
        self.navigationItem.rightBarButtonItem = _searchButton;
        
        searchText = nil;
        searchMode = NO;
        [self.searchBar resignFirstResponder];
        
    } else {
        
        _searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Cansel"
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(onSearch:)];
        
        self.navigationItem.rightBarButtonItem = _searchButton;
        
        searchMode = YES;
        [self.searchBar becomeFirstResponder];
    }
    
    [self showSearchBar];
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (searchMode == NO) {
        
        if (listNews.arrayTopNews.count > 0) {
            
            return listNews.arrayWithOutTopNews.count + 1;
            
        } else {
            
            return listNews.arrayListNews.count;
            
        }
    } else {
        
        return [listNews searchNews:searchText].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (listNews.arrayTopNews.count > 0) {
        
        if (indexPath.row == 0) {
            
            TopTableViewCell* topCell = [tableView dequeueReusableCellWithIdentifier:topTableViewCellIdentifier];
            
            topCell.listTopNews = listNews.arrayTopNews;
            
            return topCell;
            
        } else {
            
            TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:standartTableViewCellIdentifier];
            
            News* news = listNews.arrayListNews [indexPath.row];
            
            [cell submitNews:news];
            
            return cell;
        }
        
    } else {
        
        TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:standartTableViewCellIdentifier];
        
        News* news = listNews.arrayListNews [indexPath.row];
        
        cell.newsNameLable.text = news.newsName;
        [cell submitNews:news];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 287;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)theSearchText {
    
    if (theSearchText.length == 0) {
        
        searchText = nil;
        
    } else {
        
        searchText = theSearchText;
    }
    
    [_tableView reloadData];
}

#pragma mark - Private Methods

- (void)showSearchBar {
    if (searchMode == YES) {
        
        _searchBarHeight.constant = 44;
        
    } else {
        
        _searchBarHeight.constant = 0;
    }
    
    [self.view layoutIfNeeded];
}

@end
