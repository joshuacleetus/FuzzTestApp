//
//  ImagesViewController.m
//  FuzzTestApp
//
//  Created by Joshua on 3/26/15.
//  Copyright (c) 2015 Joshuasoft. All rights reserved.
//

#import "ImagesViewController.h"
#import "SBAPIManager.h"
#import "SVProgressHUD.h"
#import "DetailViewController.h"
#import "SVWebViewController.h"

@interface ImagesViewController ()

@end

@implementation ImagesViewController

-(UITableView *)makeTableView
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.rowHeight = 45;
    tableView.sectionFooterHeight = 22;
    tableView.sectionHeaderHeight = 22;
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    return tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // set white background color
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //set title
    self.title = @"Images";
        
    self.tableView = [self makeTableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"newCell"];
    [self.view addSubview:self.tableView];
    
    //call API
    [self fuzzTestAPI];
    
}

// API Call Function
- (void)fuzzTestAPI {
    //suppose there is a username and password for the api we will use the below function, here we dont need this
    [[SBAPIManager sharedManager] setUsername:nil andPassword:nil];
    
    [SVProgressHUD show];
    
    [[SBAPIManager sharedManager] GET:@"/MobileTest/test.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"response object = %@",responseObject);
        
        self.resultsArray = [NSMutableArray arrayWithArray:responseObject];
        //
        //        NSString *num_results = responseObject[@"num_results"];
        //        NSString *title_string = [NSString stringWithFormat:@"Lawyers - %@ found", num_results];
        //        self.title = title_string;
        //
        [SVProgressHUD dismiss];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
        
        //            NSLog(@"response dict = %@",dictionary);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // error stuff here
        NSLog(@"error 2= %@", error);
        [SVProgressHUD dismiss];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error")
                                                        message:[error description]
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                              otherButtonTitles: nil];
        [alert show];
    }];
    
    
}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.resultsDict[@"type"] isEqualToString:@"image"]) {
        return 210.0;
    }else{
        // "Else"
        return 0;
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newCell";
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    self.resultsDict = self.resultsArray[indexPath.item];
    self.selectedCellIndex = indexPath.row;
    
    
    for(UIView *eachView in [cell subviews]){
        NSLog(@"each view = %@, %ld",eachView, (long)eachView.tag);
        if (eachView.frame.size.height == 0.5) {
            
        }else{
            [eachView removeFromSuperview];
        }
    }
    
    if ([self.resultsDict[@"type"] isEqualToString:@"text"]|| [self.resultsDict[@"type"] isEqualToString:@"other"]) {
                
        
    }else if ([self.resultsDict[@"type"] isEqualToString:@"image"]){
        
        //        CGRect textHeight = [self.resultsDict[@"data"]
        //                             boundingRectWithSize:CGSizeMake(self.view.frame.size.width-40, 1000)
        //                             options:NSStringDrawingUsesLineFragmentOrigin
        //                             attributes:@{
        //                                          NSFontAttributeName : [UIFont systemFontOfSize:14]
        //                                          }
        //                             context:nil];
        
        //Initialize Label
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,10, 100, 100)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell addSubview:self.imageView];
        [self download:self.resultsDict[@"data"] withCompletion:^(NSData *data) {
            
        }];
        
        UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(20, self.imageView.frame.size.height+20, self.view.frame.size.width-40, 20)];
        [lbl2 setFont:[UIFont systemFontOfSize:14]];
        [lbl2 setTextColor:[UIColor grayColor]];
        lbl2.text = @"";
        [cell addSubview:lbl2];
        
        UILabel *lbl3 = [[UILabel alloc]initWithFrame:CGRectMake(20, lbl2.frame.origin.y+lbl2.frame.size.height+10, self.view.frame.size.width-40, 20)];
        [lbl3 setFont:[UIFont systemFontOfSize:14]];
        [lbl3 setTextColor:[UIColor grayColor]];
        lbl3.text = @"";
        [cell addSubview:lbl3];
        
        UILabel *lbl4 = [[UILabel alloc]initWithFrame:CGRectMake(20, lbl3.frame.origin.y+lbl3.frame.size.height+10, self.view.frame.size.width-40, 20)];
        [lbl4 setFont:[UIFont systemFontOfSize:14]];
        [lbl4 setTextColor:[UIColor grayColor]];
        lbl4.text = @"";
        [cell addSubview:lbl4];
        
        if (self.selectedCellIndex == indexPath.row) {
            

            
            
            lbl2.text = [NSString stringWithFormat:@"date: %@",self.resultsDict[@"date"]];
            
            lbl3.text = [NSString stringWithFormat:@"id: %@",self.resultsDict[@"id"]];
            
            lbl4.text = [NSString stringWithFormat:@"type: %@",self.resultsDict[@"type"]];
            
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.resultsDict2 = self.resultsArray[indexPath.row];
    if ([self.resultsDict2[@"type"] isEqualToString:@"image"]) {
        DetailViewController *media = [[DetailViewController alloc]init];
        media.typeString = self.resultsDict2[@"type"];
        media.dataDict = self.resultsDict2;
        [self.navigationController pushViewController:media animated:YES];
    }else{
        SVWebViewController *webViewController = [[SVWebViewController alloc]initWithAddress:@"https://fuzzproductions.com/"];
        [self.navigationController setNavigationBarHidden:NO];
        webViewController.title = self.resultsDict2[@"type"];
        [self.navigationController pushViewController:webViewController animated:YES];
    }
    
}

-(void)download:(NSString*)urlString withCompletion:(void(^)(NSData *data))completion {
    NSAssert(urlString, @"URL must not be nil");
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                               UIImage *image = [UIImage imageWithData:data];
                               if ([self.resultsDict[@"data"] isEqualToString:urlString]) {
                                   if (image) {
                                       self.imageView.image = image;
                                   }else{
                                       [self.imageView setImage:[UIImage imageNamed:@"no-image.jpg"]];
                                   }
                               }

                               
                               
                           }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
