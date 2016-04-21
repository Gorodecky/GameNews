//
//  TopTableViewCell.m
//  HGGameNews
//
//  Created by Serg on 18.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "TopTableViewCell.h"
#import "TopCollectionViewCell.h"

@interface TopTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation TopTableViewCell

- (void)awakeFromNib {
    
    UINib *cellNib = [UINib nibWithNibName:@"TopCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:topCollectionViewCellidentifier];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _listTopNews.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TopCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:topCollectionViewCellidentifier forIndexPath:indexPath];
    
    News * showNews = _listTopNews[indexPath.row];
    
    [cell setNews:showNews];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

@end
