
//  Created by FT_David on 16/7/11.
//  Copyright © 2016年 Benjamin Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLIndustryModel.h"

typedef void (^ButtonClick) (NSString *buttonTitle);

@interface DLIndustryCell : UITableViewCell
@property(nonatomic,assign)BOOL hideAllButton;
@property(nonatomic,strong)NSMutableArray *industryArray;
@property(nonatomic,copy)ButtonClick buttonClick;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
