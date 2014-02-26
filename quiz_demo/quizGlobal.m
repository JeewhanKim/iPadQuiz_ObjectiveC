//
//  quiz_global.m
//  quiz_demo
//
//  Created by Jeewhan on 2/10/14.
//  Copyright (c) 2014 Jeewhan. All rights reserved.
//

#import "quizGlobal.h"

static quizGlobal *globalData = nil;

@interface quizGlobal ()

@end

@implementation quizGlobal

-(void) InitQuizGlobal
{
    userName        = @"";
    widthSize       = 768;
    heightSize      = 1024;
    scrollSize      = 768;
    currentLevel    = 1;
    currentPage     = 1;
    rightCount      = 0;
    wrongCount      = 0;
    totalCount      = 5;
    pageLabelCount  = 1;
}

+(quizGlobal *)getGlobal
{
    if (globalData == nil)
    {
        globalData = [[super allocWithZone:NULL] init];
        [globalData InitQuizGlobal];
    }
    return globalData;
}

@end
