
//  Created by FT_David on 16/7/11.
//  Copyright © 2016年 Benjamin Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLIndustryModel.h"

typedef void(^ButtonClickCallBack)(NSInteger section,NSInteger buttonIdex,BOOL selected,NSString *buttonTitle);

@interface DLIndustryHeaderView : UITableViewHeaderFooterView

@property(nonatomic,strong)NSMutableArray<DLIndustryModel *> *industryArray;
@property(nonatomic,copy)ButtonClickCallBack buttonClick;
@property(nonatomic,assign)NSInteger section;

+(instancetype)headerFooterViewWithTableView:(UITableView *)tableView;
@end
