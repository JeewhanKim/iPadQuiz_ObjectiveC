//
//  quizTemplateController.h
//  quiz_demo
//
//  Created by Jeewhan on 2/10/14.
//  Copyright (c) 2014 Jeewhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "quizMainController.h"


@interface quizTemplateController : UIViewController
{    
    NSMutableArray *questionList;
    NSMutableArray *questionGen;

    NSString *answer;
    
//    quizTemplateController *quizMain;
}

-(void) SetQuizData: (NSMutableArray *)questions SetAnswer:(NSString *)answer;

@property (strong, nonatomic) IBOutlet UILabel *hintLabel_1;
@property (strong, nonatomic) IBOutlet UILabel *hintLabel_2;
@property (strong, nonatomic) IBOutlet UILabel *hintLabel_3;
@property (strong, nonatomic) IBOutlet UILabel *hintLabel_4;
@property (strong, nonatomic) IBOutlet UILabel *hintLabel_5;

@property (strong, nonatomic) IBOutlet UILabel *quizNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *CurCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *MaxCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *correctAnswer;

@property (strong, nonatomic) IBOutlet UIButton *buttonSubmit;
@property (strong, nonatomic) IBOutlet UIButton *buttonNext;
@property (strong, nonatomic) IBOutlet UIButton *buttonPrev;
@property (strong, nonatomic) IBOutlet UIButton *buttonResult;

@property (strong, nonatomic) IBOutlet UITextField *answerField;

@property (strong, nonatomic) IBOutlet UIImageView *rightAnswer;
@property (strong, nonatomic) IBOutlet UIImageView *wrongAnswer;

@end
