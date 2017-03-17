
//  Created by FT_David on 16/7/11.
//  Copyright © 2016年 Benjamin Gordon. All rights reserved.
//

#import "DLIndustryCell.h"
#import "UIColor+Hex.h"
@interface DLIndustryCell()

@property(nonatomic,strong)NSMutableArray<UIButton *> *industryButtonArray;
@property(nonatomic,strong)UIButton *selectedButton;
@end

@implementation DLIndustryCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"IndustryCellID";
    DLIndustryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DLIndustryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        cell.contentView.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.industryButtonArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)setIndustryArray:(NSMutableArray *)industryArray
{
    _industryArray = industryArray;
    if (self.industryArray.count > self.industryButtonArray.count) {
        NSInteger needButtonCount = self.industryArray.count - self.industryButtonArray.count;
        for (int i = 0; i < needButtonCount; i++) {
            UIButton *button = [[UIButton alloc] init];
            [self.industryButtonArray addObject:button];
        }
    }
    
    UIColor *buttonBoarderColor = [UIColor colorWithHexString:@"#b0b0b0"];
    UIColor *buttonTitleColor = [UIColor colorWithHexString:@"#888888"];
    for (int i = 0; i < self.industryArray.count; i++) {
        
        UIButton *button = self.industryButtonArray[i];
        [button removeFromSuperview];
        button.selected = NO;
        [button setTitle:industryArray[i] forState:UIControlStateNormal];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#00afea"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 3;
        button.layer.borderColor = buttonBoarderColor.CGColor;
        [self.contentView addSubview:button];
    }
}

-(void)setHideAllButton:(BOOL)hideAllButton
{
    _hideAllButton = hideAllButton;
    for (int i = 0; i < self.industryArray.count; i++) {
        UIButton *button = self.industryButtonArray[i];
        button.hidden = hideAllButton;
    }
}

-(void)buttonAction:(UIButton *)button
{
    UIColor *buttonTitleColor = [UIColor colorWithHexString:@"#b0b0b0"];
    self.selectedButton.selected = NO;
    self.selectedButton.layer.borderColor = buttonTitleColor.CGColor;
    button.selected = YES;
    button.layer.borderColor = [UIColor colorWithHexString:@"#00afea"].CGColor;
    self.selectedButton = button;
    
    if (self.buttonClick) {
        self.buttonClick(self.selectedButton.titleLabel.text);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat buttonHeight = 35;
    CGFloat margin = 15;
    CGFloat startY = 10;
    CGFloat buttonMargin = 20;
    CGFloat buttonWidth = (viewWidth - 2 * margin - 2 * buttonMargin)/3;
    for (int i = 0; i < self.industryArray.count; i++) {
        UIButton *button = self.industryButtonArray[i];
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        button.frame = CGRectMake(index *(buttonWidth + buttonMargin) + margin, page * (buttonHeight + startY) + startY, buttonWidth, buttonHeight);
    }
}

@end
