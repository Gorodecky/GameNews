//
//  TopCollectionViewCell.m
//  HGGameNews
//
//  Created by Serg on 13.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "TopCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface TopCollectionViewCell () <UITextViewDelegate> {
    NSURL * redirectURL;
}
@end

@implementation TopCollectionViewCell

- (void)awakeFromNib {
    
    _newsLink.delegate = self;
    _newsLink.editable = NO;
    _newsLink.scrollEnabled =NO;
    _newsLink.dataDetectorTypes = UIDataDetectorTypeLink;
    _newsLink.backgroundColor = [UIColor clearColor];
    
}

- (void) setNews:(News*) news {
    
    redirectURL = news.newsLink;
    
    _newsName.text = news.newsName;
    
    _newsDate.text = [news newsTimeDifferense];
    
    if (news.newsPhotoUrl) {
        
        [self.newsImage setImageWithURL:news.newsPhotoUrl
                       placeholderImage:[UIImage imageNamed: @"400*200"]];
    }
    
    if (news.newsLink) {
        
        _newsLink.hidden = NO;
        _newsLink.text = [news showUrlString];
        
    } else {
        
        _newsLink.hidden = YES;
    }
    
}
#pragma mark  - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    [[UIApplication sharedApplication] openURL:redirectURL];
    
    return NO;
}

@end
