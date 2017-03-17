
//  Created by FT_David on 16/7/11.
//  Copyright © 2016年 Benjamin Gordon. All rights reserved.
//

#import "DLIndustryHeaderView.h"
#import "UIButton+Extension.h"
#import "UIColor+Hex.h"
@interface DLIndustryHeaderView ()

@property(nonatomic,strong)NSMutableArray<UIButton *> *buttonArray;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIImageView *backImage;
@property(nonatomic,strong)UIButton *selectedButton;
@end

@implementation DLIndustryHeaderView

+(instancetype)headerFooterViewWithTableView:(UITableView *)tableView
{
    static NSString *headerFooter = @"headerViewID";
    DLIndustryHeaderView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerFooter];
    if (!headerFooterView) {
        headerFooterView = [[DLIndustryHeaderView alloc] initWithReuseIdentifier:headerFooter];
        headerFooterView.tintColor = [UIColor colorWithHexString:@"#f0f0f0"];
    }

    return headerFooterView;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.buttonArray = [[NSMutableArray alloc] init];
        [self setbackImage];
        [self setupLine];
    }
    
    return self;
}

-(void)setupLine
{
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#e7e7e9"];
    
    [self.contentView addSubview:self.lineView];
}

-(void)setbackImage
{
    self.backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newLS_industry_headerbackgroundImage"]];
    [self.contentView addSubview:self.backImage];
}
-(void)setIndustryArray:(NSMutableArray<DLIndustryModel *> *)industryArray
{
    _industryArray = industryArray;
    
    if (self.industryArray.count > self.buttonArray.count ) {
        NSInteger needButtonCount = self.industryArray.count -  self.buttonArray.count;
        for (int i = 0; i < needButtonCount; i++) {
            UIButton *button = [[UIButton alloc] init];
            [self.contentView addSubview:button];
            [self.buttonArray addObject:button];
        }
    }
  
    UIColor *buttonTitleColor = [UIColor colorWithHexString:@"#666666"];
    for (int i = 0; i < self.industryArray.count;i++) {
        DLIndustryModel *model = self.industryArray[i];
        UIButton *button = self.buttonArray[i];
        button.selected = NO;
        [button setTitle:model.industry forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:model.image] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:model.selectedImage] forState:UIControlStateSelected];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#00afea"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;

        if (model.selected == YES) {
            button.selected = YES;
            self.selectedButton = button;
        }
        
    }
}

-(void)buttonAction:(UIButton *)button
{
    if (button == self.selectedButton) {
        self.selectedButton.selected = !button.selected;
        self.selectedButton = button;
    }else{
        self.selectedButton.selected = NO;
        button.selected = YES;
        self.selectedButton = button;
    }
    NSString *buttonTitle = self.selectedButton.selected ? self.selectedButton.titleLabel.text : nil;
    if (self.buttonClick) {
        self.buttonClick(self.section,button.tag,self.selectedButton.selected,buttonTitle);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonHeight = self.frame.size.height;
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat lineWidth = 1.5;
    CGFloat marginWidth = 10;
    CGFloat lineMargin = 15;
    CGFloat buttonWidht = (viewWidth - lineWidth)/2;
    self.backImage.frame = CGRectMake(marginWidth, 0, viewWidth - 2 * marginWidth, buttonHeight);
    
    for (int i = 0; i < self.buttonArray.count; i++) {
        UIButton *button = self.buttonArray[i];
        if (i == 0) {
            button.frame = CGRectMake(0, 0, buttonWidht, buttonHeight);
        }else{
            button.frame = CGRectMake(buttonWidht + lineWidth, 0, buttonWidht, buttonHeight);
        }
        
        [button verticalImageAndTitle:0];
    }
    
    self.lineView.frame = CGRectMake(buttonWidht, lineMargin, lineWidth, buttonHeight- 2 * lineMargin);
}
@end
