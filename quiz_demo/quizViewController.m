//
//  quizViewController.m
//  quiz_demo
//
//  Created by Jeewhan on 2/7/14.
//  Copyright (c) 2014 Jeewhan. All rights reserved.
//

#import "quizViewController.h"
#import "quizGlobal.h"

@interface quizViewController ()

@end

@implementation quizViewController

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
    
    globalPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    globalDocumentsDirectory = [globalPaths objectAtIndex:0];
    globalFilePath = [globalDocumentsDirectory stringByAppendingPathComponent:@"data.xml"];
    
    [self initBeforeStart];
}

- (void)textFieldDidEndEditing:(UITextField *)nameField
{
    if (![nameField.text isEqualToString:@""]){
        NSLog(@"Name : %@", name);
        
        [nameField resignFirstResponder];
        [self startButtonDisplay];
        
        return;
    }
}

- (void)initBeforeStart
{
    // Check Saved data.XML File
    NSLog(@"Load File Path : %@", globalFilePath);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:globalFilePath]) {
        [self initTitleDisplay];
    } else {
        [self initDisplay];
    }
}


-(NSString *) stringByXML:(NSString *) savedFile stringByParse:(NSString *) parse
{
    NSString *findByStartTag = [NSString stringWithFormat:@"<%@>", parse];
    NSString *findByEndTag = [NSString stringWithFormat:@"</%@>", parse];
    
    NSRange startTag = [savedFile rangeOfString:findByStartTag];
    NSRange endTag = [savedFile rangeOfString:findByEndTag];
    
    if(startTag.length == 0 && endTag.length == 0) return savedFile;
    
    int lengt = endTag.location - startTag.location - startTag.length;
    int location = startTag.location + startTag.length;
    
    NSRange findRange;
    findRange.location = location;
    findRange.length = lengt;
    savedFile = [savedFile substringWithRange:findRange];
    
    return savedFile;
}

- (void)initDisplay
{
    self.view.alpha = 0.0f;
    
    [UIView
     animateWithDuration:1.0f
     delay:0
     options:UIViewAnimationOptionCurveEaseInOut
     animations:^{
         self.view.alpha = 1.0f;
     }
     completion:^(BOOL finished){
         
     }];
}

- (void)initTitleDisplay
{
    NSString *savedFile = [[NSString alloc] initWithContentsOfFile:globalFilePath encoding:NSUTF8StringEncoding error:NULL];
    name = [self stringByXML:savedFile stringByParse:@"name"];
    
    NSLog(@"file : %@", savedFile);
    _nameLabel.text = [NSString stringWithFormat:@"%@", name];
    
    [self.view addSubview:_titleView];
    
    [UIView
     animateWithDuration:1.0f
     delay:0
     options:UIViewAnimationOptionCurveEaseInOut
     animations:^{
         self.view.alpha = 1.0f;
     }
     completion:^(BOOL finished){
         
     }];
    
}

- (void)startButtonDisplay
{
    NSLog(@"@startButtonDisplay");
    
    [UIView
     animateWithDuration:1.0f
     delay:0
     options:UIViewAnimationOptionCurveEaseInOut
     animations:^{
         self.buttonStart.alpha = 1.0f;
     }
     completion:^(BOOL finished){
         
     }];
}

- (void) saveData
{
    NSLog(@"@saveData");
    
    // save data with XML format
    NSDictionary *object = [[NSMutableDictionary alloc]init];
    [object setValue:_nameField.text forKey:@"name"];
    [object setValue:@"dd/mm/yyyy hh:mm:ss" forKey:@"registerDate"];
    
    NSString *xmlString = [[NSString alloc] init];
    xmlString = [self convertToXml:object];

    NSString *saveString;
    saveString = [NSString stringWithFormat:@"<?xml version='1.0' encoding='UTF-8'?>\n%@", xmlString];
    
    NSLog(@"%@", saveString);

    [saveString writeToFile:globalFilePath atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
}

-(NSString *)convertToXml:(NSDictionary *)dictionary
{
    NSMutableString *xmlString = [[NSMutableString alloc] init];
    
    for (NSString *key in [dictionary allKeys]) {
        id value = [dictionary objectForKey:key];
        [xmlString appendFormat:@"<%@>%@</%@>\n", key, value, key];
    }
    
    return [NSString stringWithString:xmlString];
}

- (BOOL)textFieldShouldReturn:(UITextField *)nameField
{
    [self toTitleAction];
    return YES;
}
- (IBAction) toTitle:(id)sender
{
    [self toTitleAction];
}

-(void)toTitleAction
{
    if([_nameField.text isEqualToString:@""]) {
        NSLog(@"@emptyName");
        return;
    }
    
    [_nameField resignFirstResponder];
    
    [self saveData];
    
    NSLog(@"@toTitle");
    
    [UIView
     animateWithDuration:1.0f
     delay:0
     options:UIViewAnimationOptionCurveEaseInOut
     animations:^{
         self.view.alpha = 0.0f;
     }
     completion:^(BOOL finished){
         [self initTitleDisplay];
         _nameField.text = @"";
     }];
}

- (IBAction) moveRecordFromMain:(id)sender
{
    MainView = [[quizMainController alloc] init];
    [self.view addSubview:MainView.view];
    [self.view bringSubviewToFront:MainView.view];
    
    [MainView MoveRecordPageDirectly];
//    MainView.view.alpha = 0.0f;
//    
//    [UIView
//     animateWithDuration:1.0f
//     delay:0
//     options:UIViewAnimationOptionCurveEaseInOut
//     animations:^{
//         MainView.view.alpha = 1.0f;
//     }
//     completion:^(BOOL finished){
//         [MainView MoveRecordPageDirectly];
//     }];
}

- (IBAction) deleteRecord:(id)sender
{
    NSLog(@"@deleteRecord");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to delete your account? This action cannot be undone" delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"Cancel", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        
        [[NSFileManager defaultManager] removeItemAtPath:globalFilePath error:NULL];
        
        NSLog(@"@delete");
        
        name = @"";
        
        [_titleView removeFromSuperview];
        [self initDisplay];
        
    }
}

- (IBAction) toMainDisplay:(id)sender
{
    NSLog(@"@toMainDisplay");
    
    _buttonQuizStart.enabled = NO;
    
    MainView = [[quizMainController alloc] init];
    [self.view addSubview:MainView.view];
    [self.view bringSubviewToFront:MainView.view];
    MainView.view.alpha = 0.0f;
    
    [UIView
     animateWithDuration:1.0f
     delay:0
     options:UIViewAnimationOptionCurveEaseInOut
     animations:^{
         MainView.view.alpha = 1.0f;
     }
     completion:^(BOOL finished){
         [MainView initQuizDisplay];
         _buttonQuizStart.enabled = YES;
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
