
//  Created by FT_David on 16/7/11.
//  Copyright © 2016年 Benjamin Gordon. All rights reserved.
//

#import "DLIndustryFooterView.h"

@implementation DLIndustryFooterView

+(instancetype)headerFooterViewWithTableView:(UITableView *)tableView
{
    static NSString *headerFooter = @"footerViewID";
    DLIndustryFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerFooter];
    if (!headerFooterView) {
        headerFooterView = [[DLIndustryFooterView alloc] initWithReuseIdentifier:headerFooter];
    }
    return headerFooterView;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {

    }
    
    return self;
}

@end
