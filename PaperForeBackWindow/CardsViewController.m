//
//  CardsViewController.m
//  upDownTransition
//
//  Created by Hao Zheng on 8/9/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "CardsViewController.h"
#import "SecondViewController.h"
#import "largeLayout.h"
#import "EDCollectionCell.h"
#import "dragViewBehavior.h"
#import "draggableViewState.h"

@interface CardsViewController () 

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIAttachmentBehavior *panAttachment;
@property (nonatomic) dragViewState state;

@property (nonatomic, strong) dragViewBehavior *dragBehavior;

@end

static NSString *CellIdentifier = @"Cell";

@implementation CardsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadControls];
    
    
}

-(void)loadControls{
    //registering dequueue cell
    [self.collectionView registerClass:[EDCollectionCell class] forCellWithReuseIdentifier:CellIdentifier];
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.layer.cornerRadius = 8.0f;
    
    
    // Pan for a dismissal using UIKit Dynamics
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.view addGestureRecognizer:panGesture];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view.superview];
    //NSLog(@"what!!: %@",self.collectionView.superview);
}

- (void)didPan:(UIPanGestureRecognizer *)gesture{
    
    CGPoint location = [gesture locationInView:self.view.superview];
    
    //NSLog(@"what: %@",self.view.superview);
    
    

    
    
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            
            // Cleanup existing behaviors like the "snap" behavior when, after a pan starts, this view
            // gets snapped back into place
            [self.animator removeAllBehaviors];
            
            // Give the view some rotation
//            UIDynamicItemBehavior *rotationBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.view]];
//            //rotationBehavior.allowsRotation = YES;
//            //rotationBehavior.angularResistance = 10.0f;
//            
//            [self.animator addBehavior:rotationBehavior];
//            
//            // Calculate the offset from the center of the view to use in the attachment behavior
//            CGPoint viewCenter = self.view.center;
//            UIOffset centerOffset = UIOffsetMake(location.x - viewCenter.x, location.y - viewCenter.y);
//            
//            // Attach to the location of the pan in the container view.
//            self.panAttachment = [[UIAttachmentBehavior alloc] initWithItem:self.view
//                                                           offsetFromCenter:centerOffset
//                                                           attachedToAnchor:location];
//            self.panAttachment.damping = 0.7f;
//            self.panAttachment.length = 0;
//            [self.animator addBehavior:self.panAttachment];
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            // Now when the finger moves around we just update the anchor point,
            // which will move the view around
            //self.panAttachment.anchorPoint = location;
            
            
            //offset
            CGPoint offsetXandY = [gesture translationInView:self.view.superview];
            
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y + offsetXandY.y);
            
            [gesture setTranslation:CGPointZero inView:self.view.superview];
            
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            // Not enough velocity to exit the modal, so snap it back into the center of the screen
//            [self.animator removeAllBehaviors];
//            
//            UISnapBehavior *snapIt = [[UISnapBehavior alloc] initWithItem:self.view snapToPoint:CGPointMake(160, 284)];
//            snapIt.damping = 0.7;
//            
//            [self.animator addBehavior:snapIt];
            
            CGPoint velocity = [gesture velocityInView:self.view.superview];
            
            velocity.x = 0;
            
            if(velocity.y >= 0){    //going down, which means closing
                self.state = StateClosed;
            }else{
                self.state = StateOpen;
            }
            
            [self animateDragViewWithInitialVelocity:velocity];

            break;
        }
        default:
            break;
    }
}


- (void)animateDragViewWithInitialVelocity:(CGPoint)initialVelocity{
    
    if (!self.dragBehavior) {
        NSLog(@"init once for dragView behavior");
        self.dragBehavior = [[dragViewBehavior alloc] initWithItem:self.view];
    }
    self.dragBehavior.targetPoint = self.targetPoint;
    self.dragBehavior.velocity = initialVelocity;
    
    //once added, it will effect
    [self.animator addBehavior:self.dragBehavior];
}

- (CGPoint)targetPoint{
    
    CGSize size = self.view.bounds.size;
    
    CGPoint result;
    
    if(self.state == StateClosed){
        result = CGPointMake(size.width/2, size.height+200);
    }else{
        result = CGPointMake(size.width/2, size.height/2);
    }
    return result;
}


/*******************************
 
 collection view delegate
 
 *****************************/
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EDCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    //[cell configFIVForCell:indexPath.row withFood:self.foodArray[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //present secondVC
    SecondViewController *viewController = [[SecondViewController alloc] initWithCollectionViewLayout:[[largeLayout alloc] init]];
    viewController.useLayoutToLayoutNavigationTransitions = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateNormal;
}

@end
