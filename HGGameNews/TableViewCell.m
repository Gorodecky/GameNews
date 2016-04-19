//
//  TableViewCell.m
//  HGGameNews
//
//  Created by Serg on 18.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "TableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "News.h"
@interface TableViewCell () <UITextViewDelegate>
{
    NSURL *redirectURL;
}

@end

@implementation TableViewCell

- (void)awakeFromNib {
    
    _newsLinkLable.editable = NO;
    _newsLinkLable.scrollEnabled = NO;
    _newsLinkLable.dataDetectorTypes = UIDataDetectorTypeLink;
    _newsLinkLable.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (void) submitNews: (News*) news {
    
    redirectURL = news.newsLink;
    
    if (news.newsPhotoUrl) {
        _imageHeight.constant = 186;
        
        [self.newsImageLable setImageWithURL:news.newsPhotoUrl
                            placeholderImage:[UIImage imageNamed: @"400*200"]];
    } else {
        
        _imageHeight.constant = 0;
    }
    
    [self updateConstraints];
    
    _newsNameLable.text = news.newsName;
    
    _newsDateLable.text = [news newsTimeDifferense];
    
    if (news.newsLink) {
        
        _newsLinkLable.text = [news showUrlString];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    [[UIApplication sharedApplication] openURL:redirectURL];
    
    return NO;
}

#pragma mark - Private

- (void)prepareForReuse {
    redirectURL = nil;
    
    _newsImageLable.image = nil;
    
    _newsLinkLable.delegate = nil;
}


@end
