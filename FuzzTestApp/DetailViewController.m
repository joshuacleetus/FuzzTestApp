//
//  DetailViewController.m
//  FuzzTestApp
//
//  Created by Joshua on 3/27/15.
//  Copyright (c) 2015 Joshuasoft. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    if ([self.dataDict[@"type"] isEqualToString:@"image"]) {
        self.title = @"Image";
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height/4, self.view.frame.size.width-40, self.view.frame.size.width-40)];
        [self.imageView setImage:[UIImage imageNamed:@"no-image.jpg"]];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:self.imageView];
        
        [self download:self.dataDict[@"data"] withCompletion:^(NSData *data) {
            
        }];
        
    }
}

-(void)download:(NSString*)urlString withCompletion:(void(^)(NSData *data))completion {
    NSAssert(urlString, @"URL must not be nil");
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                               UIImage *image = [UIImage imageWithData:data];
                               if (image) {
                                   self.imageView.image = image;
                               }
                               
                               
                           }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
