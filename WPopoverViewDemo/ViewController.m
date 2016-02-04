//
//  ViewController.m
//  WPopoverViewDemo
//
//  Created by wenchao on 16/2/2.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import "ViewController.h"
#import "PopoverViewController.h"
#import "WPopoverView.h"
#import "WTablePopView.h"

@interface ViewController () //<UIPopoverPresentationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
    UIButton *button1 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 20, 120, 40);
        [btn setTitle:@"actionsheet1" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onPopoverClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 104;
        btn ;
    });
    [self.view addSubview:button1];
    */
    
    UIButton *button2 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 80, 100, 40);
        [btn setTitle:@"上左" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onTablePopViewClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 105;
        btn ;
    });
    [self.view addSubview:button2];
    
    UIButton *button23 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(self.view.center.x - 20, 80, 40, 40);
        [btn setTitle:@"上中" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onTablePopViewClick:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    [self.view addSubview:button23];
    
    UIButton *button3 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(200, 80, 120, 40);
        [btn setTitle:@"上右" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onTablePopViewClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 106;
        btn ;
    });
    [self.view addSubview:button3];
    
    UIButton *button4 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(10, self.view.bounds.size.height - 100, 120, 40);
        [btn setTitle:@"下左" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onPopoverViewClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 107;
        btn ;
    });
    [self.view addSubview:button4];
    
    UIButton *button45 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(self.view.center.x - 20, button4.frame.origin.y, 40, 40);
        [btn setTitle:@"下中" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onPopoverViewClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 108;
        btn ;
    });
    [self.view addSubview:button45];
    
    UIButton *button5 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(220, button4.frame.origin.y, 100, 40);
        [btn setTitle:@"下右" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onPopoverViewClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 108;
        btn ;
    });
    [self.view addSubview:button5];
    
    UIButton *buttonleft = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(10, self.view.center.y, 80, 40);
        [btn setTitle:@"中左" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onPopoverLeftClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 109;
        btn ;
    });
    [self.view addSubview:buttonleft];
    
    UIButton *buttonright = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(self.view.bounds.size.width - 80, self.view.center.y, 80, 40);
        [btn setTitle:@"中右" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onPopoverRightClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 110;
        btn ;
    });
    [self.view addSubview:buttonright];

    UIButton *buttonleft1 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(10, self.view.bounds.size.height - 50, 80, 40);
        [btn setTitle:@"左" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onPopoverLeftClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 109;
        btn ;
    });
    [self.view addSubview:buttonleft1];
    
    UIButton *buttonright1 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(self.view.bounds.size.width - 80, buttonleft1.frame.origin.y, 80, 40);
        [btn setTitle:@"右" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onPopoverRightClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 110;
        btn ;
    });
    [self.view addSubview:buttonright1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onTablePopViewClick:(UIButton *)sender {
    
    WTablePopView *tablePop = [WTablePopView new];
    WPopoverView *popView = [[WPopoverView alloc] initWithAttachView:tablePop];
    popView.sourceRect = sender.frame;
    popView.popoverArrowDirection = WPopoverArrowDirectionUp;
    popView.popoverContentSize = CGSizeMake(300, 200);
    
    [popView show];
}

- (void)onPopoverViewClick:(UIButton *)sender {
    WTablePopView *tablePop = [WTablePopView new];
    WPopoverView *popView = [[WPopoverView alloc] initWithAttachView:tablePop];
    popView.sourceRect = sender.frame;
    popView.popoverArrowDirection = WPopoverArrowDirectionDown;
    popView.popoverContentSize = CGSizeMake(300, 200);
    
    [popView show];
}

- (void)onPopoverLeftClick:(UIButton *)sender {
    WTablePopView *tablePop = [WTablePopView new];
    WPopoverView *popView = [[WPopoverView alloc] initWithAttachView:tablePop];
    popView.sourceRect = sender.frame;
    popView.popoverArrowDirection = WPopoverArrowDirectionLeft;
    popView.popoverContentSize = CGSizeMake(150, 200);
    
    [popView show];
}

- (void)onPopoverRightClick:(UIButton *)sender {
    WTablePopView *tablePop = [WTablePopView new];
    WPopoverView *popView = [[WPopoverView alloc] initWithAttachView:tablePop];
    popView.sourceRect = sender.frame;
    popView.popoverArrowDirection = WPopoverArrowDirectionRight;
    popView.popoverContentSize = CGSizeMake(150, 200);
    
    [popView show];
}
/*
- (void)onPopoverClick:(UIButton *)sender {

    UIStoryboard *bord = [UIStoryboard storyboardWithName:@"Main" bundle:nil] ;
    PopoverViewController    *pop = [bord instantiateViewControllerWithIdentifier:@"PopoverController"];
    
    pop.modalPresentationStyle = UIModalPresentationPopover;
    pop.popoverPresentationController.delegate = self;
    UIPopoverPresentationController *detailPopover = pop.popoverPresentationController;
    detailPopover.delegate = self;
    detailPopover.sourceView = sender;
    detailPopover.sourceRect = sender.frame;
    detailPopover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    [self presentViewController:pop animated:YES completion:nil];
    
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle :(UIModalPresentationStyle)style {    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller.presentedViewController];
    return navController;

}
*/
@end
