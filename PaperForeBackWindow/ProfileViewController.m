//
//  ProfileViewController.m
//  upDownTransition
//
//  Created by Hao Zheng on 8/9/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "ProfileViewController.h"
#import "SettingsCell.h"

@interface ProfileViewController ()

@property (nonatomic, strong) UIViewController *cardsVC;

@property (strong,nonatomic) NSArray *profileData;

@property (strong,nonatomic) NSArray *profileImagesData;

@end

@implementation ProfileViewController

const NSString *settingCellIdentity = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor orangeColor];
    
    //also init secondVC
    self.cardsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Cards"];
    
    
    self.profileData = [NSArray arrayWithObjects:
                     @"aa",
                     @"bb",
                     @"cc",
                     nil];
    self.profileImagesData = [NSArray arrayWithObjects:
                           [UIImage imageNamed:@"EDB_language.png"],
                           [UIImage imageNamed:@"EDB_tutorial.png"],
                           [UIImage imageNamed:@"EDB_aboutus.png"],
                           nil];
}



#pragma mark - UICollectionViewDataSource Methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.profileData count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SettingsCell *cell = (SettingsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[settingCellIdentity copy] forIndexPath:indexPath];
    cell.profileLabel.text = [self.profileData objectAtIndex:indexPath.row];
    cell.profileImageView.image = self.profileImagesData[indexPath.row];
    return cell;
    
}



@end