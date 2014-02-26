//
//  quizMainController.h
//  quiz_demo
//
//  Created by Jeewhan on 2/10/14.
//  Copyright (c) 2014 Jeewhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "quizTemplateController.h"

@interface quizMainController : UIViewController <UIScrollViewDelegate>
{
    UIScrollView *ScrollView;
    NSMutableArray *QuizViewList;
    quizMainController *QuizTemplate[15];
    
}

-(void)initQuizDisplay;
-(void)MoveNextPage : (int)page;
-(void)MovePrevPage : (int)page;
-(void)NextLevel : (int)currentLevel;
-(void)MoveRecordPage;
-(void)SaveRecord;
-(void)buttonHomeClickEvent;
-(void)MoveRecordPageDirectly;

@property (strong, nonatomic) IBOutlet UIButton *buttonHome;
@property (strong, nonatomic) IBOutlet UILabel *recordNameLabel;

@end
