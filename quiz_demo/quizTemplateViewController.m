//
//  quizTemplateViewController.m
//  quiz_demo
//
//  Created by Jeewhan on 2/10/14.
//  Copyright (c) 2014 Jeewhan. All rights reserved.
//

#import "quizTemplateViewController.h"


@interface quizTemplateViewController ()

@end

@implementation quizTemplateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) SetQuizData: (NSArray *)questions SetAnswer:(NSString *)answer
{
    
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
}

@end
