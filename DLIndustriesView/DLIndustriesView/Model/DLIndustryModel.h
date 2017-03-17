
//  Created by FT_David on 16/7/8.
//  Copyright © 2016年 Benjamin Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DLIndustryModel : NSObject
/** 行业 */
@property(nonatomic,copy)NSString *industry;
/** 工作 */
@property(nonatomic,copy)NSArray *jobs;
/** 索引 */
@property(nonatomic,assign)NSInteger index;
/** 普通图片 */
@property(nonatomic,copy) NSString *image;
/** 选中图片 */
@property(nonatomic,copy)NSString *selectedImage;
/** Cell的高度 */
@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,assign)BOOL selected;

+(NSMutableArray *)getIndustryData;
@end
