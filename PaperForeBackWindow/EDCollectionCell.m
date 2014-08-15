//
//  EDCollectionCell.m
//  Paper
//
//  Created by Hao Zheng on 6/11/14.
//  Copyright (c) 2014 Heberti Almeida. All rights reserved.
//

#import "EDCollectionCell.h"
//#import "LoadControls.h"
#import "largeLayout.h"
#import "smallLayout.h"

@interface EDCollectionCell()

@property (strong,nonatomic,readwrite) NSString *foodTitle;
@end

@implementation EDCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 8.0f;
    
}

@end
