//
//  FNNetManager.m
//  YellowPage
//
//  Created by feinno on 15/1/28.
//  Copyright (c) 2015年 feinno. All rights reserved.
//

#import "FNNetManager.h"

@interface FNNetManager()
@property(nonatomic,retain)AFHTTPRequestOperationManager *operationManager;
@property(nonatomic,retain)NSMutableDictionary *cmdArgus;

@end

@implementation FNNetManager

+(FNNetManager *)shared{
    static FNNetManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FNNetManager alloc]init];
        
        manager.operationManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:FNConfigServerBaseURL]];
        manager.operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.operationManager.requestSerializer setValue:@"Application/json"forHTTPHeaderField:@"Accept"];
        [manager.operationManager.requestSerializer setValue:@"Application/json; charset=utf-8"forHTTPHeaderField:@"Content-Type"];

    });
    return manager;
}
/**
 *  获取推荐商家列表
 */
-(void)getRecShopsFC:(NSString *)fc sc:(NSString *)sc finish:(void (^) (NSArray *shops))finish failure:(void (^) (NSError *error))failure{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"getRecShops",@"function",
                            fc,@"first_category",
                            sc,@"second_category",
                            [NSString stringWithFormat:@"%f",FNConfigUserCoordinate.longitude],@"longitude",
                            [NSString stringWithFormat:@"%f",FNConfigUserCoordinate.latitude],@"latitude",
                            nil];
//    NSLog(@"%@",params);
    [self.operationManager POST:FNConfigServerAppComponent parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        NSArray *arr = [[NSArray arrayWithObject:responseObject] objectAtIndex:0];
        NSMutableArray *shops = [NSMutableArray array];

        for (NSDictionary *cardInfo in arr){
            NSObject *entity = [FNRunTime equipmentEntityWithClass:[FNShopArgs class] data:cardInfo];
            [shops addObject:entity];
        }
        finish(shops);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        NSLog(@"%@",error);
    }];
}






@end
