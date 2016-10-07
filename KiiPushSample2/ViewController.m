//
//  ViewController.m
//  KiiPushSample2
//
//  Created by satoshi on 2016/10/06.
//  Copyright © 2016年 Kii. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <KiiSDK/Kii.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UILabel *infoText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogin:(id)sender {
    NSString* username = _usernameText.text;
    NSString* password = _passwordText.text;
    AppDelegate* app = [[UIApplication sharedApplication]delegate];
    [KiiUser authenticate:username withPassword:password andBlock:^(KiiUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to login %@", error);
            return;
        }
        _infoText.text = @"Login success!";

        NSData* token = app.token;
        if (!token) {
            _infoText.text = @"No device token";
            return;
        }
        [KiiPushInstallation installWithDeviceToken:token andDevelopmentMode:YES andCompletion:^(KiiPushInstallation * _Nullable installation, NSError * _Nullable error) {
            if (error != nil) {
                _infoText.text = @"Failed to install device token";
                return;
            }
            _infoText.text = @"Installation Succeeded.";
            KiiBucket *bucket = [user bucketWithName:@"PushTest"];
            KiiPushSubscription *subscription = user.pushSubscription;
            [subscription subscribe:bucket block:^(KiiPushSubscription * _Nonnull subscription, NSError * _Nullable error) {
                if (error != nil) {
                    _infoText.text = @"Failed to subscribe bucket";
                    return;
                }
                _infoText.text = @"Subscription succeeded.";
            }];

        }];
    }];
}

@end
