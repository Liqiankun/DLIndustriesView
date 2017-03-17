
//  Created by FT_David on 16/7/8.
//  Copyright © 2016年 Benjamin Gordon. All rights reserved.
//

#import "DLIndustryModel.h"

@implementation DLIndustryModel

+(NSMutableArray *)getIndustryData{
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"NewIndustries" withExtension:@"plist"]];
    NSMutableArray *firstArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count; i++) {
        NSMutableArray *secondArray = [[NSMutableArray alloc] init];
        NSMutableArray *subArray = array[i];
        for (int j = 0; j < subArray.count; j++) {
            NSDictionary *dic = subArray[j];
            DLIndustryModel *model = [[DLIndustryModel alloc] init];
            model.industry = dic[@"industry"];
            model.jobs = dic[@"jobs"];
            model.index = j;
            model.image = dic[@"image"];
            model.selectedImage = dic[@"selectedImage"];
            model.selected = NO;
            [secondArray addObject:model];
        }
        [firstArray addObject:secondArray];
    }
    return firstArray;
}

-(void)setJobs:(NSArray *)jobs
{
    _jobs = jobs;
    CGFloat buttonHeight = 35;
    self.cellHeight = [self rowOfJobs:jobs] * (10 + buttonHeight) + 5;
}

-(NSUInteger)rowOfJobs:(NSArray *)jobs
{
    NSUInteger result =  jobs.count % 3;
   return result == 0 ? jobs.count/3 : jobs.count/3 + 1;
}

@end
