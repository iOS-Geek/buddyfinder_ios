//
//  GuideViewController.m
//  buddyApp
//
//  Created by Manish Anand on 30/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _guideScreenScrollview.delegate=self;
    
    
//    [_guideScreenScrollview setContentSize:CGSizeMake(5*self.view.frame.size.width, self.view.frame.size.height)];
//    
//    _guideScreenScrollview.clipsToBounds=true;
//       _guideScreenScrollview.pagingEnabled = YES;
//    
//     
//    [_guideScreenScrollview bringSubviewToFront:_grayTransparentView];
//    // scrollView.minimumZoomScale = 0.3;
//    // scrollView.maximumZoomScale = 4;
//    
//    // [scrollView setShowsHorizontalScrollIndicator:false];
//    _guideScreenScrollview.userInteractionEnabled=true;
//    
//    
//    NSInteger numberOfViews = 5;
//    for (int i = 0; i < numberOfViews; i++) {
//        
//        CGFloat xOrigin = i * self.view.frame.size.width;
//        _guideImage.frame = CGRectMake(xOrigin, 0, self.view.frame.size.width, self.view.frame.size.height);
//        _guideImage.backgroundColor = [UIColor colorWithRed:0.5/i green:0.5 blue:0.5 alpha:1];
//        
//        
//        
//        
//        
//        [_guideScreenScrollview addSubview:_guideImage];
//      
//        
//        
//    }
//
//    [_guideImage addSubview:_pageController];
//    
//    [_pageController addTarget:self action:@selector(myaction) forControlEvents:UIControlEventValueChanged];
//    
//    
//    _pageController.currentPage=0;
//    //pg.tintColor = [UIColor blackColor];
//      
//        [self.view addSubview:_guideScreenScrollview];
//    _pageController.defersCurrentPageDisplay=true;
//    
//    NSLog(@"scrolling is happening");
//   // NSLog(@"x = %f  and y = %f ",scrollView.contentOffset.x,scrollView.contentOffset.y);
//    
    

    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView  // any offset changes
{
    NSLog(@"scrolling is happening");
    NSLog(@"x = %f  and y = %f ",_guideScreenScrollview.contentOffset.x,_guideScreenScrollview.contentOffset.y);
    
    if (scrollView.contentOffset.x==640) {
        _pageController.currentPage=2;
    }
    else if (scrollView.contentOffset.x==320)
    {
        _pageController.currentPage=1;
    }
    else if (scrollView.contentOffset.x==0)
    {
        _pageController.currentPage=0;
    }
    else if (scrollView.contentOffset.x==960)
    {
        _pageController.currentPage=3;
    }
    else if (scrollView.contentOffset.x==1280)
    {
        _pageController.currentPage=4;
    }
    //    for(;scrollView.contentOffset.x==i*self.view.frame.size.width;)
    //    {
    //        pg.currentPage=i;
    //        i++;
    //    }
    
    
    [_pageController updateCurrentPageDisplay];
    
    
}




- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    
    
    
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



@end
