//
//  AppDelegate.h
//  testWebChatSDK
//
//  Created by Luck on 17/6/7.
//  Copyright © 2017年 hongmw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

