//
//  SFMetroTypicalCell.m
//  MetroUIDemo
//
//  Created by 郑庆登(King Zheng)-企业内部系统研发中心 on 2018/7/18.
//  Copyright © 2018年 sinno. All rights reserved.
//

#import "SFMetroTypicalCell.h"
@interface SFMetroTypicalCell()
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *subjectImgView;

@end
@implementation SFMetroTypicalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)refreshWithModel:(SFMetroCellBaseModel*)model{
    if (model.backgroundColor) {
        self.backgroundColor = model.backgroundColor;
    }
    self.subjectLabel.text = model.subjectName;
    NSString* subjectImg = model.subjectImg?model.subjectImg:@"Subject_chat";
    self.subjectImgView.image = [UIImage imageNamed:subjectImg];
}
@end
