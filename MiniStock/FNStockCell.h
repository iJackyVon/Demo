//
//  FNRootCell.h
//  MiniStock
//
//  Created by feinno on 15/5/29.
//  Copyright (c) 2015年 feinno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNHeaders.h"

@interface FNStockCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *rate;

@end
