//
//  scrollViewController.m
//  buddyApp
//
//  Created by Manish Anand on 31/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import "scrollViewController.h"
#import "MyNavigationControllerViewController.h"
@interface scrollViewController ()
{
    UIView *theView;
    UIPageControl *pg;
    UIImageView *imgView;
    BuddyViewController *buddyView;
    float fullWidth;
    UISwipeGestureRecognizer *gst;
    UIScrollView *scrollView;
    bool guideViewFinished;
    MyNavigationControllerViewController *nav;
    BuddyViewController *ivc;
}
@end

@implementation scrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appdelegate.enablePortrait=YES;
    bool c;
    c= true;
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"seenTutorial"]  isEqual: @"true"]) {
       // [self.navigationController dismissViewControllerAnimated:false completion:nil];
        BuddyViewController *ivc = [self.storyboard instantiateViewControllerWithIdentifier:@"hello"];
        //        ivc.label = self.label.text;
        [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"seenTutorial"];

        [self.navigationController pushViewController:ivc animated:NO];

    }
    

    self.view.backgroundColor = [UIColor colorWithRed:0.137254902 green:0.137254902 blue:0.137254902 alpha:1.0];
    [self.navigationController setNavigationBarHidden:true];
    buddyView = [[BuddyViewController alloc]init];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height+20)];
    scrollView.showsHorizontalScrollIndicator=false;
    scrollView.showsVerticalScrollIndicator=false;
   // self.view.backgroundColor = [ UIColor whiteColor];
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIImage *img1 = [UIImage imageNamed:@"working.png"];
    UIImage *img2 = [UIImage imageNamed:@"working2.png"];
    UIImage *img3 = [UIImage imageNamed:@"working3.png"];
    guideViewFinished=false;
    NSMutableArray *images = [NSMutableArray arrayWithObjects:img1,img2,img3,nil];
    
    gst = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLastPage:)];
    
    scrollView.clipsToBounds=true;
    scrollView.delegate=self;
    //scrollView.pagingEnabled = YES;
    
    scrollView.pagingEnabled=true;
    
    
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"seenTutorial"];
    // scrollView.minimumZoomScale = 0.3;
    // scrollView.maximumZoomScale = 4;
    
    // [scrollView setShowsHorizontalScrollIndicator:false];
    scrollView.userInteractionEnabled=true;
    
    
    pg = [[UIPageControl alloc]initWithFrame:CGRectMake(110, 535, 100, 20)];
    
    
    [pg addTarget:self action:@selector(myaction) forControlEvents:UIControlEventValueChanged];
    
    pg.numberOfPages=3;
    pg.currentPage=0;
    pg.tintColor = [UIColor blackColor];
    
    
    //[_pgc addTarget:self action:@selector(changepage:) forControlEvents:UIControlEventTouchUpInside];

    ivc = [self.storyboard instantiateViewControllerWithIdentifier:@"hello"];
    
    NSInteger numberOfViews = 3;
    for (int i = 0; i < numberOfViews; i++) {
        
        CGFloat xOrigin = i * self.view.frame.size.width;
       // theView = [[UIView alloc] initWithFrame:CGRectMake(xOrigin, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        theView.backgroundColor = [UIColor colorWithRed:0.5/i green:0.5 blue:0.5 alpha:1];
        [imgView setImage:[images objectAtIndex:i]];
//        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
//        myLabel.text = [NSString stringWithFormat:@"This is page number %d", i+1];
        
        
        
        [scrollView addSubview:imgView];
//        [theView addSubview:myLabel];
        
        
    }
    
    pg = [[UIPageControl alloc]initWithFrame:CGRectMake(self.view.frame.size.width *0.40, self.view.frame.size.height* 0.95, 100, 30 )];
    
    
    [pg addTarget:self action:@selector(myaction) forControlEvents:UIControlEventValueChanged];
    
    pg.numberOfPages=3;
    
    pg.currentPage=0;
    pg.tintColor = [UIColor blueColor];
    
    pg.defersCurrentPageDisplay=true;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * numberOfViews, self.view.frame.size.height-100);
    [self.view addSubview:scrollView];
    
    
    //[self.view addSubview:pg];
   // [scrollView bringSubviewToFront:pg];
    [scrollView addSubview: _viewGray];
  
     pg.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new3.png"]];
    pg.currentPageIndicatorTintColor = [UIColor orangeColor];
    pg.pageIndicatorTintColor = [UIColor whiteColor];
    //scrollView.contentOffset = CGPointMake(10, 40);
    //   [scrollView bounces:true];
    //scrollView.bounces=false;
    //
    //    scrollView.alwaysBounceVertical = false;
    //     scrollView.alwaysBounceHorizontal = false;
    
    //[scrollView setContentOffset:CGPointMake(700,200) animated:true];
    
    //    [UIView animateWithDuration:5 animations:^{
    //        scrollView.contentOffset = CGPointMake(1000, 300);
    //    }];
    
    
    fullWidth=scrollView.frame.size.width;
    
    NSLog(@"scrolling is happening");
    NSLog(@"x = %f  and y = %f ",scrollView.contentOffset.x,scrollView.contentOffset.y);
    
   
    
    
    
}
//
//-(void)changepage:(id)sender
//{
//    int page = _pgc.currentPage;
//    if (page < 0)
//        return;
//    if (page > 2)
//        return;
//    CGRect frame = scrollView.frame;
//    frame.origin.x = frame.size.width * page;
//    frame.origin.y = 0;
//    [scrollView scrollRectToVisible:frame animated:YES];
//    
//}
//- (IBAction)changePage:(id)sender {
//    UIPageControl *pager=sender;
//    int page = pager.currentPage;
//    CGRect frame = scrollView.frame;
//    frame.origin.x = frame.size.width * page;
//    frame.origin.y = 0;
//    [scrollView scrollRectToVisible:frame animated:YES];
//}

- (IBAction)nextPageAction:(id)sender {
    
    
   
    int page = _pgc.currentPage;
    //    if (page < 0)
    //        return;
    //    if (page > 2)
    //        return;
    if (page!=2) {
        
    
    page=page+1;
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    }
    else
    {
    

        
        //        ivc.label = self.label.text;
        //[self.navigationController pushViewController:ivc animated:NO];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"dismissTutorial"] isEqual:@"false"]) {
            [    self.navigationController pushViewController:ivc animated:YES];
            
        }
        else
        {
            [self.navigationController popViewControllerAnimated:false];
        }

//        }
    }
}


-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
}

//
//
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait; // or Right of course
}
//////
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait;
//}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
        
    {
        return  UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return true;
}
-(void)myaction
{
    //pg.currentPage=2;
    
    
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    
}


//
//
//-(void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated
//{
//    contentOffset.x = 0;
//    contentOffset.y = 0;
//
//}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView  // any offset changes
{
    NSLog(@"scrolling is happening");
    NSLog(@"x = %f  and y = %f ",scrollView.contentOffset.x,scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.x==fullWidth*2) {
        pg.currentPage=2;
        _pgc.currentPage=2;
        
        [_rightPgc setImage:[UIImage imageNamed:@"new3.png"] forState:UIControlStateNormal];
        [_leftPg setImage:[UIImage imageNamed:@"dss2.png"] forState:UIControlStateNormal];
        [_centerPgc setImage:[UIImage imageNamed:@"dss2.png"] forState:UIControlStateNormal];

        [_nextButton setTitle:@"DONE" forState:UIControlStateNormal];
        _skipButton.hidden=true;
        guideViewFinished=true;
    }
    else if (scrollView.contentOffset.x==fullWidth)
    {
        pg.currentPage=1;
        _pgc.currentPage=1;

        [_centerPgc setImage:[UIImage imageNamed:@"dss4.png"] forState:UIControlStateNormal];
        [_leftPg setImage:[UIImage imageNamed:@"dss2.png"] forState:UIControlStateNormal];
        [_rightPgc setImage:[UIImage imageNamed:@"dss2.png"] forState:UIControlStateNormal];
        guideViewFinished=false;
        [_nextButton setTitle:@"NEXT" forState:UIControlStateNormal];
        _skipButton.hidden=false;


    }
    else if (scrollView.contentOffset.x==0)
    {
        pg.currentPage=0;
        _pgc.currentPage=0;

        [_leftPg setImage:[UIImage imageNamed:@"dss4.png"] forState:UIControlStateNormal];
        [_rightPgc setImage:[UIImage imageNamed:@"dss2.png"] forState:UIControlStateNormal];

        [_centerPgc setImage:[UIImage imageNamed:@"dss2.png"] forState:UIControlStateNormal];
        guideViewFinished=false;
        [_nextButton setTitle:@"NEXT" forState:UIControlStateNormal];
        _skipButton.hidden=false;

    }
    else if (scrollView.contentOffset.x>=fullWidth*2.06)
    {
                     NSLog(@" last page");
////        [self.navigationController pushViewController:buddyView animated:false];
////        [self.storyboard instantiateViewControllerWithIdentifier:@"hello"];
//        BuddyViewController *ivc = [self.storyboard instantiateViewControllerWithIdentifier:@"hello"];
////        ivc.label = self.label.text;
//        [self.navigationController pushViewController:ivc animated:YES];
        
        
        
    }
//    else
//        if (scrollView.contentOffset.x < 0 && scrollView.contentOffset.y < 0) {
//            scrollView.contentOffset = CGPointMake(0, 0);
//        }
//    else if (scrollView.contentOffset.x==960)
//    {
//        pg.currentPage=3;
//    }
//    else if (scrollView.contentOffset.x==1280)
//    {
//        pg.currentPage=4;
//    }
//    //    for(;scrollView.contentOffset.x==i*self.view.frame.size.width;)
//    //    {
//    //        pg.currentPage=i;
//    //        i++;
//    //    }
//    
    
    [pg updateCurrentPageDisplay];
    
    
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.x==fullWidth*2+1) {
//        if (scrollView.contentOffset.x>fullWidth) {
//            NSLog(@"not a last page");
//        }
//        else
//        {
//             NSLog(@" last page");
//        }
                     NSLog(@" last page");

        }
        
      
    
   


    
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView   // called on finger up as we are moving
{
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView      // called when scroll view grinds to a halt
{
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}


- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView   // return a yes if you want to scroll to the top. if not defined, assumes YES
{
    
    return true;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)skipAction:(id)sender {
   // BuddyViewController *ivc = [self.storyboard instantiateViewControllerWithIdentifier:@"hello"];
    //        ivc.label = self.label.text;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"dismissTutorial"] isEqual:@"false"]) {
        [    self.navigationController pushViewController:ivc animated:YES];

    }
    else
    {
    [self.navigationController popViewControllerAnimated:false];
    }
    
}
@end
