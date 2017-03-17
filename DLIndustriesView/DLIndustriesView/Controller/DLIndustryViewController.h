
//  Created by FT_David on 16/7/11.
//  Copyright © 2016年 Benjamin Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^IndustryCallBack)(NSString *industry,NSString *role);

@interface DLIndustryViewController : UIViewController

@property(nonatomic,copy)IndustryCallBack callBack;

@end
