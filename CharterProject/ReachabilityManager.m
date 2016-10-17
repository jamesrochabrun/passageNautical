
//
//  ReachabilityManager.m
//  CharterProject
//
//  Created by James Rochabrun on 10/14/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "ReachabilityManager.h"
#import "MainViewController.h"

@implementation ReachabilityManager

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _reachability = [Reachability reachabilityForInternetConnection];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:@"test1" object:self];
    }
    return self;
}

- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability {
    
    [self configureLabel:nil  withReachability:reachability];
}

- (void)configureLabel:(UILabel *)label withReachability:(Reachability *)reachability {
    
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    NSString* statusString = @"";
    
    switch (netStatus)
    {
        case NotReachable:        {
            statusString = NSLocalizedString(@"Access Not Available", @"Text field text for access is not available");
            label.hidden = NO;
            /*
             Minor interface detail- connectionRequired may return YES even when the host is unreachable. We cover that up here...
             */
            connectionRequired = NO;
            
            
            break;
        }
            
        case ReachableViaWWAN:        {
            statusString = NSLocalizedString(@"Reachable WWAN", @"");
            label.hidden = YES;
            //  [self getDataFromApi];
            break;
        }
        case ReachableViaWiFi:        {
            statusString= NSLocalizedString(@"Reachable WiFi", @"");
            label.hidden = YES;
            //  [self getDataFromApi];
            break;
        }
    }
    
    if (connectionRequired)
    {
        NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
        statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    
    NSLog(@"%@", statusString);
    label.text = statusString;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}



@end

