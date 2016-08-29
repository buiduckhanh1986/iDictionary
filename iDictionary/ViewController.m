//
//  ViewController.m
//  iDictionary
//
//  Created by Bui Duc Khanh on 8/25/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewController.h"


#define trim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;
@property (weak, nonatomic) IBOutlet UILabel *lblResult;

@end

@implementation ViewController
{
    NSDictionary * data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    data = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
    
    [_txtSearch setText:data[@"a"][0][@"word"]];
    
    [self onBtnSearchTouchUpInside:nil];
}

- (IBAction)onBtnSearchTouchUpInside:(id)sender {
    NSString * word = _txtSearch.text;
    
    if (word == nil || word.length == 0 || [trim(word) length] == 0)
    {
        [self.lblResult setText:@""];
    }
    else
    {
        word = trim([word lowercaseString]);
        NSString *meaning = nil;
        
        NSString *key = [word substringToIndex:1];
        
        NSArray *dic = [data objectForKey:key];
        
        if (dic != nil)
        {
            for (NSDictionary *item in dic)
                if ([item[@"word"] isEqualToString:word])
                {
                    meaning = item[@"meaning"];
                }
        }
        
        if (meaning != nil)
            [self.lblResult setText:meaning];
        else
            [self.lblResult setText:@"Không thấy từ cần tra"];
            
    }
    
}

@end
