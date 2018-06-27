//
//  ViewController.m
//  SizeClassesTestByStoryboard
//
//  Created by Victor Macintosh on 27/06/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ViewController.h"

typedef enum {
    redSquare,
    blueSquare
} SquareType;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@property (assign, nonatomic) BOOL redViewIsFolded;
@property (assign, nonatomic) BOOL blueViewIsFolded;
@property (assign, nonatomic) CGFloat margin;

@end

@implementation ViewController

//MARK:- Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.redViewIsFolded = NO;
    self.blueViewIsFolded = NO;
    self.margin = 20.0;
}

//MARK:- TraitCollectionMethods

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self updateConstraintsForNewTraitCollection:newCollection forSquare:redSquare];
    [self updateConstraintsForNewTraitCollection:newCollection forSquare:blueSquare];
}

//MARK:- IBActions

- (IBAction)wasTappedButtonForRedSquare:(id)sender {
    [self updateConstraintsBySender:redSquare];
    self.redViewIsFolded = !self.redViewIsFolded;
}

- (IBAction)wasTappedButtonForBlueSquare:(id)sender {
    [self updateConstraintsBySender:blueSquare];
    self.blueViewIsFolded = !self.blueViewIsFolded;
}

//MARK:- Updaring constraints methods

- (void)updateConstraintsBySender:(SquareType)square {

    CGFloat constraintValue;
    
    if (square == redSquare) {
        self.blueViewIsFolded = NO;
        if (self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
            constraintValue = self.redViewIsFolded ? -1.5 * self.margin : -self.view.frame.size.height / 4;
        } else {
            constraintValue = self.redViewIsFolded ? -1.5 * self.margin : -self.view.frame.size.width / 4;
        }
    } else if (square == blueSquare) {
        self.redViewIsFolded = NO;
        if (self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
            constraintValue = self.blueViewIsFolded ? -1.5 * self.margin : self.view.frame.size.height / 4 - 3 * self.margin;
        } else {
            constraintValue = self.blueViewIsFolded ? -1.5 * self.margin : self.view.frame.size.width / 4 - 3 * self.margin;
        }
    } else {
        return;
    }
    
    self.heightConstraint.constant = constraintValue;
    self.widthConstraint.constant = constraintValue;
    
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

- (void)updateConstraintsForNewTraitCollection:(UITraitCollection*)traitCollection forSquare:(SquareType)square {
    
    CGFloat constraintValue;
    
    if (square == redSquare) {
        if (self.blueViewIsFolded) {
            return;
        }
        if (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
            constraintValue = !self.redViewIsFolded ? -1.5 * self.margin : -self.view.frame.size.width / 4;
        } else {
            constraintValue = !self.redViewIsFolded? -1.5 * self.margin : -self.view.frame.size.height / 4;
        }
    } else if (square == blueSquare) {
        if (self.redViewIsFolded) {
            return;
        }
        if (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
            constraintValue = !self.blueViewIsFolded ? -1.5 * self.margin : self.view.frame.size.width / 4 - 3 * self.margin;
        } else {
            constraintValue = !self.blueViewIsFolded ? -1.5 * self.margin : self.view.frame.size.height / 4 - 3 * self.margin;
        }
    } else {
        return;
    }
    
    self.heightConstraint.constant = constraintValue;
    self.widthConstraint.constant = constraintValue;
    
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
    
}

@end
