//
//  quizTemplateController.m
//  quiz_demo
//
//  Created by Jeewhan on 2/10/14.
//  Copyright (c) 2014 Jeewhan. All rights reserved.
//

#import "quizTemplateController.h"
#import "quizGlobal.h"

@interface quizTemplateController ()

@end

@implementation quizTemplateController

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
    
    quizGlobal *global = [quizGlobal getGlobal];
    
    self.view.frame = CGRectMake(0, 0, global->widthSize, global->heightSize );
    
    questionList = [[NSMutableArray alloc] init];
    
    NSMutableArray *quizGenerator = [self makeQuizList];
    
    for(int k = 0; k < global->totalCount; k++)
    {
        for(int i = 0; i < 5; i++)
        {
            questionList[i] = quizGenerator[i];
        }
    }
    
    answer = [[NSString alloc]init];
    answer = quizGenerator[5];
    
    [self SetQuizData:questionList SetAnswer:answer];
    
    _CurCountLabel.text = [NSString stringWithFormat:@"%D", global->pageLabelCount];
    _MaxCountLabel.text = [NSString stringWithFormat:@"%D", global->totalCount];
    _quizNameLabel.text = global->userName;
    
    global->pageLabelCount += 1;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) SetQuizData: (NSMutableArray *)questions SetAnswer:(NSString *)answer
{
    _hintLabel_1.text = [questions objectAtIndex:0];
    _hintLabel_2.text = [questions objectAtIndex:1];
    _hintLabel_3.text = [questions objectAtIndex:2];
    _hintLabel_4.text = [questions objectAtIndex:3];
    _hintLabel_5.text = [questions objectAtIndex:4];
}

- (BOOL)textFieldShouldReturn:(UITextField *)answerField
{
    NSLog(@"@checkTheAnswer_text");
    [self checkTheAnswerFunction];
    return YES;
}
- (IBAction) checkTheAnswer:(id)sender
{
    [self checkTheAnswerFunction];
}

-(void) checkTheAnswerFunction
{
    NSLog(@"@checkTheAnswer");
    
    if([_answerField.text isEqualToString:@""]) {
        NSLog(@"@empayAnswer");
        return;
    }
    
    _buttonSubmit.enabled = NO;
    
    [_answerField resignFirstResponder];
    
    if([ [_answerField.text lowercaseString] isEqualToString:[answer lowercaseString]]) {
        NSLog(@"@rightAnswer");
        
        [UIView
         animateWithDuration:1.0f
         delay:0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             _rightAnswer.alpha = 0.3f;
             _buttonSubmit.alpha = 0.0f;
         }
         completion:^(BOOL finished){
             quizGlobal *global = [quizGlobal getGlobal];
             global->rightCount += 1;
             
             [self nextDisplay];
         }];
        
        return;
    } else {
        NSLog(@"@wrongAnswer");
        _correctAnswer.text = answer;
        
        [UIView
         animateWithDuration:1.0f
         delay:0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             _wrongAnswer.alpha = 0.3f;
             _correctAnswer.alpha = 0.8f;
             _buttonSubmit.alpha = 0.0f;
         }
         completion:^(BOOL finished){
             quizGlobal *global = [quizGlobal getGlobal];
             global->wrongCount += 1;
             
             [self nextDisplay];
         }];
        
        return;
    }
}


-(void) nextDisplay
{
    quizGlobal *global = [quizGlobal getGlobal];
    NSLog(@"currentLevel : %d / currentPage : %d / ", global->currentLevel, global->currentPage);
    
    [UIView
     animateWithDuration:0.3f
     delay:0
     options:UIViewAnimationOptionCurveEaseInOut
     animations:^{
         if(global->currentLevel < global->totalCount) _buttonNext.alpha = 1.0f;
         if(global->currentLevel > 1) _buttonPrev.alpha = 1.0f;
         if(global->currentLevel >= global->totalCount) _buttonResult.alpha = 1.0f;
     }
     completion:^(BOOL finished){
         
         if(global->currentLevel > global->totalCount){
             NSLog(@"score : ");
         }
         else {
             global->currentLevel += 1;
             
             [global->quizMainView NextLevel:global->currentLevel];
         }
     }];
}
-(IBAction) checkRecord:(id)sender
{
    NSLog(@"save");
    
    quizGlobal *global = [quizGlobal getGlobal];
    
    [global->quizMainView SaveRecord];
    [global->quizMainView MoveRecordPage];
}

-(IBAction) nextLevel:(id)sender
{
    quizGlobal *global = [quizGlobal getGlobal];
    NSLog(@"currentPage : %d", global->currentPage);
    [global->quizMainView MoveNextPage:(global->currentPage)];
}

-(IBAction) prevLevel:(id)sender
{
    quizGlobal *global = [quizGlobal getGlobal];
    [global->quizMainView MovePrevPage:(global->currentPage)];
}

-(IBAction)buttonHomeClick:(id)sender
{
    quizGlobal *global = [quizGlobal getGlobal];
    [global->quizMainView buttonHomeClickEvent];
    
    NSLog(@"buttonHomeClick");
}

-(NSMutableArray *)makeQuizList
{
    int random = arc4random() % 5;
    
    questionGen = [[NSMutableArray alloc] init];
    
    switch(random)
    {
        case 0:
            questionGen[0] = @"It is an American multinational corporation headquatrered in Cupertino, California.";
            questionGen[1] = @"It was founded by Steve Jobs, Steve Wozniak and RonaldWayne.";
            questionGen[2] = @"It develops its own operating system.";
            questionGen[3] = @"It also offers online services with iCloud";
            questionGen[4] = @"It has been a participant in various legal proceedings and claims since it began operation";
            questionGen[5] = @"Apple";
            break;
        case 1:
            questionGen[0] = @"This color model (process color, four color) is a subtractive color model, used in color printing";
            questionGen[1] = @"This model works by partially or entirely masking colors on a lighter, usually white, background.";
            questionGen[2] = @"Cyan, Magenta, Yellow, and Key (black).";
            questionGen[3] = @"In this model, white is the natural color of the paper or other background.";
            questionGen[4] = @"";
            questionGen[5] = @"CMYK";
            break;
        case 2:
            questionGen[0] = @"This is a server-side scripting language designed for web development.";
            questionGen[1] = @"This is now installed on more than 244 million websites and 2.1 million web servers";
            questionGen[2] = @"This offers a well defined and documented way for writing custom extensions in C or C++.";
            questionGen[3] = @"This development began in 1994 when the developer Rasmus Lerdorf wrote a series of CGI Perl scripts";
            questionGen[4] = @"This is a general-purpose scripting language that is especially suited to server-side web development.";
            questionGen[5] = @"PHP";
            break;
        case 3:
            questionGen[0] = @"Douglas Crockford was the first to specify and popularize the format.";
            questionGen[1] = @"This is an open standard format that uses human-readable text";
            questionGen[2] = @"It was used at State Software Inc.";
            questionGen[3] = @"Basic types are Number, String, Boolean, Array, Object and null";
            questionGen[4] = @"";
            questionGen[5] = @"json";
            break;
        case 4:
            questionGen[0] = @"It is an OOP language that adds Smalltalk-style messaging to the C programming language";
            questionGen[1] = @"Originally developed in the early 1980s";
            questionGen[2] = @"It is a thin layer on top of C, and moreover is a strict superset of C";
            questionGen[3] = @"It is based on message passing to object instances";
            questionGen[4] = @"It requires that the interface and implementation of a class be in separately declared code blocks";
            questionGen[5] = @"objective c";
            break;
        case 5:
            questionGen[0] = @"50";
            questionGen[1] = @"51";
            questionGen[2] = @"52";
            questionGen[3] = @"53";
            questionGen[4] = @"54";
            questionGen[5] = @"sadd";
            break;
        case 6:
            questionGen[0] = @"50";
            questionGen[1] = @"51";
            questionGen[2] = @"52";
            questionGen[3] = @"53";
            questionGen[4] = @"54";
            questionGen[5] = @"sadd";
            break;
        case 7:
            questionGen[0] = @"50";
            questionGen[1] = @"51";
            questionGen[2] = @"52";
            questionGen[3] = @"53";
            questionGen[4] = @"54";
            questionGen[5] = @"sadd";
            break;
        case 8:
            questionGen[0] = @"50";
            questionGen[1] = @"51";
            questionGen[2] = @"52";
            questionGen[3] = @"53";
            questionGen[4] = @"54";
            questionGen[5] = @"sadd";
            break;
        case 9:
            questionGen[0] = @"50";
            questionGen[1] = @"51";
            questionGen[2] = @"52";
            questionGen[3] = @"53";
            questionGen[4] = @"54";
            questionGen[5] = @"sadd";
            break;
    }
    
    questionGen[6] = [NSString stringWithFormat:@"%D", random];
    
    return questionGen;
    
}

@end
