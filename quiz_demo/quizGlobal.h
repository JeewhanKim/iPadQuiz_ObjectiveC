//
//  quiz_global.h
//  quiz_demo
//
//  Created by Jeewhan on 2/10/14.
//  Copyright (c) 2014 Jeewhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "quizViewController.h"
#import "quizMainController.h"
#import "quizTemplateController.h"

@interface quizGlobal : NSObject
{
    @public
    NSString    *userName;
    NSArray     *quizRecord;
    
    int         widthSize;
    int         heightSize;
    int         scrollSize;
    int         currentLevel;
    int         currentPage;    
    int         rightCount;
    int         wrongCount;
    int         totalCount;
    int         pageLabelCount;

    
    UIScrollView *ScrollView;
    
    quizMainController *quizMainView;
    
//    NSDate *regDate;
    
    
}

+(quizGlobal *)getGlobal;

@end
