//
//  quizMainController.m
//  quiz_demo
//
//  Created by Jeewhan on 2/10/14.
//  Copyright (c) 2014 Jeewhan. All rights reserved.
//

#import "quizMainController.h"
#import "quizGlobal.h"

@interface quizMainController ()

@end

@implementation quizMainController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    quizGlobal *global = [quizGlobal getGlobal];
    global->quizMainView = self;
    _recordNameLabel.text = global->userName;
    
    [self makeScrollView];
}

-(void)makeScrollView
{
    quizGlobal *global = [quizGlobal getGlobal];
    
    self.view.frame = CGRectMake(0, 0, global->widthSize, global->heightSize);
    
    ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, global->widthSize, global->heightSize)];
    [self.view addSubview:ScrollView];
    
    [ScrollView setContentSize:CGSizeMake( global->widthSize, global->heightSize) ];
    [ScrollView setPagingEnabled:YES];
    [ScrollView setBounces:NO];
    [ScrollView setScrollEnabled:YES];
    [ScrollView setShowsHorizontalScrollIndicator:NO];
    [ScrollView setShowsVerticalScrollIndicator:NO];
    [ScrollView setDelegate:self];
    
    QuizViewList = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < global->totalCount; i++)
    {
        QuizTemplate[i] = [[quizTemplateController alloc] init];
        QuizTemplate[i].view.frame = CGRectMake( global->widthSize * i, 0, global->widthSize, global->heightSize );
        
        [ScrollView addSubview:QuizTemplate[i].view];
    }
    
    NSLog(@"Main - viewDidLoad");
}

- (void)initQuizDisplay
{
    NSLog(@"Main - initDisplay");

}

-(void) MoveNextPage : (int)page
{
    quizGlobal *global = [quizGlobal getGlobal];
    
    if (page >= global->totalCount) return;
    
    [ScrollView setContentOffset:CGPointMake( global->widthSize * page, 0) animated:YES];
//    [UIView animateWithDuration:0.8f delay:0 options:UIViewAnimationOptionCurveEaseInOut
//     animations:^{
//       [ScrollView setContentOffset:CGPointMake( global->widthSize * page, 0) animated:NO];
//     } completion:nil];
    
    global->currentPage += 1;
    
}

-(void) MovePrevPage : (int)page
{
    quizGlobal *global = [quizGlobal getGlobal];
//    NSLog(@"page : %d, currentPage : %d", page, global->currentPage );
    if (page < 1 ) return;
    
    [ScrollView setContentOffset:CGPointMake( global->widthSize * (page - 2), 0) animated:YES];
    
    global->currentPage -= 1;
}

-(void)NextLevel : (int)currentLevel
{
    
    quizGlobal *global = [quizGlobal getGlobal];
    
    if (global->currentLevel > global->totalCount) return;
    
    global->scrollSize = global->widthSize * (currentLevel);
    
    NSLog(@"Next Level : %d", currentLevel);
    [ScrollView setContentSize:CGSizeMake( global->scrollSize, global->heightSize) ];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    quizGlobal *global = [quizGlobal getGlobal];
    NSInteger pageNumber = lround(ScrollView.contentOffset.x / ScrollView.bounds.size.width) + 1;

    if ( global->currentPage != pageNumber)
    {
        global->currentPage = pageNumber;
        
	}
}
-(void)MoveRecordPageDirectly
{
    ScrollView.alpha = 0.0f;
    
    [self displayRecord];
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
-(void)MoveRecordPage
{
    [UIView
     animateWithDuration:1.0f
     delay:0
     options:UIViewAnimationOptionCurveEaseInOut
     animations:^{
         ScrollView.alpha = 0.0f;
     }
     completion:^(BOOL finished){
         [self displayRecord];
     }];
}

-(void)SaveRecord
{
    quizGlobal *global = [quizGlobal getGlobal];
    NSLog(@"@SavedRecord");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"data.xml"];
    
    NSString *savedFile = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    
    // save data with XML format
    NSDictionary *object = [[NSMutableDictionary alloc]init];
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    [object setValue:[NSString stringWithFormat:@"%d", global->rightCount] forKey:@"rightCount"];
    [object setValue:[NSString stringWithFormat:@"%d", global->totalCount] forKey:@"totalCount"];
    [object setValue:[DateFormatter stringFromDate:[NSDate date]] forKey:@"regDate"];
    
    NSString *xmlString = [[NSString alloc] init];
    xmlString = [self convertToXml:object];
    
    NSString *saveString;
    saveString = [NSString stringWithFormat:@"%@<data>\n%@</data>\n", savedFile, xmlString];
    
    [saveString writeToFile:filePath atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
}

-(void) displayRecord
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"data.xml"];
    
    NSString *savedFile = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    
    NSArray *dataArray = [savedFile componentsSeparatedByString:@"<data>"];
    
    for(int i=1; i<dataArray.count; i++)
    {  
        NSString *rightCount = [self stringByXML:dataArray[i] stringByParse:@"rightCount"];
        NSString *totalCount = [self stringByXML:dataArray[i] stringByParse:@"totalCount"];
        NSString *regDate = [self stringByXML:dataArray[i] stringByParse:@"regDate"];
        
        NSLog(@"dataArray[%d] : %@, %@, %@", i, rightCount, totalCount, regDate);
        
        int top = 144 + (i*40);
        
        // Display List
        UILabel *seqLabel = [[UILabel alloc] initWithFrame:CGRectMake(163, top, 112, 24)];
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(352, top, 33, 24)];
        UILabel *middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(382, top, 33, 24)];
        UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(401, top, 30, 24)];
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(510, top, 201, 24)];
        
        // Display UILabel Style
        seqLabel.font = [UIFont systemFontOfSize:15.0];
        seqLabel.textColor = [UIColor grayColor];
        rightLabel.font = [UIFont systemFontOfSize:15.0];
        rightLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green:149.0f/255.0f blue:109.0f/255.0f alpha:1.0f];
        middleLabel.font = [UIFont systemFontOfSize:15.0];
        middleLabel.textColor = [UIColor grayColor];
        totalLabel.font = [UIFont systemFontOfSize:15.0];
        totalLabel.textColor = [UIColor colorWithRed:106.0f/255.0f green:106.0f/255.0f blue:106.0f/255.0f alpha:1.0f];
        dateLabel.font = [UIFont systemFontOfSize:15.0];
        dateLabel.textColor = [UIColor grayColor];
    
        seqLabel.text = [NSString stringWithFormat:@"%d", i ];
        rightLabel.text = rightCount;
        middleLabel.text = @"/";
        totalLabel.text = totalCount;
        dateLabel.text = regDate;
        
        seqLabel.alpha = 0.0f;
        rightLabel.alpha = 0.0f;
        middleLabel.alpha = 0.0f;
        totalLabel.alpha = 0.0f;
        dateLabel.alpha = 0.0f;
        
        [self.view addSubview:seqLabel];
        [self.view addSubview:rightLabel];
        [self.view addSubview:middleLabel];
        [self.view addSubview:totalLabel];
        [self.view addSubview:dateLabel];
        
        [UIView animateWithDuration:1.0f delay:0.0f
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             seqLabel.alpha = 1.0f;
             rightLabel.alpha = 1.0f;
             middleLabel.alpha = 1.0f;
             totalLabel.alpha = 1.0f;
             dateLabel.alpha = 1.0f;
         }
         completion:^(BOOL finished){}];
        
    }
    
    
    
}


// To Be Rearranged..

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

-(NSString *)convertToXml:(NSDictionary *)dictionary
{
    NSMutableString *xmlString = [[NSMutableString alloc] init];
    
    for (NSString *key in [dictionary allKeys]) {
        id value = [dictionary objectForKey:key];
        [xmlString appendFormat:@"<%@>%@</%@>\n", key, value, key];
    }
    
    return [NSString stringWithString:xmlString];
}

-(void)buttonHomeClickEvent
{
    NSLog(@"buttonHomeClick");
    
    [UIView
     animateWithDuration:1.0f
     delay:0
     options:UIViewAnimationOptionCurveEaseInOut
     animations:^{
         ScrollView.alpha = 0.0f;
         self.view.alpha = 0.0f;
     }
     completion:^(BOOL finished){
         quizGlobal *global = [quizGlobal getGlobal];
         global -> scrollSize      = 768;
         global -> currentLevel    = 1;
         global -> currentPage     = 1;
         global -> rightCount      = 0;
         global -> wrongCount      = 0;
         global -> totalCount      = 5;
         global -> pageLabelCount  = 1;
     }];
}
-(IBAction)buttonHomeClick:(id)sender
{
    [self buttonHomeClickEvent];
}
@end
