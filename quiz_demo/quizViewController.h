//
//  quizViewController.h
//  quiz_demo
//
//  Created by Jeewhan on 2/7/14.
//  Copyright (c) 2014 Jeewhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "quizMainController.h"


@interface quizViewController : UIViewController
{
    NSString *name;
    
    NSArray *globalPaths;
    NSString *globalDocumentsDirectory;
    NSString *globalFilePath;

    
    quizMainController *MainView;
}

@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UIButton *buttonStart;
@property (strong, nonatomic) IBOutlet UIButton *buttonRecord;
@property (strong, nonatomic) IBOutlet UIButton *buttonQuizStart;
@property (strong, nonatomic) IBOutlet UIButton *buttonDelete;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

-(NSString *)convertToXml:(NSDictionary *)dictionary;

@end
