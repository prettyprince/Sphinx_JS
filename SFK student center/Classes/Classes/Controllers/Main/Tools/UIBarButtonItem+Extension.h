//
//  UIBarButtonItem+Extension.h
//  
//
//  Created by jeemy on 14-10-7.
//  Copyright (c) 2014年 jeemy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
