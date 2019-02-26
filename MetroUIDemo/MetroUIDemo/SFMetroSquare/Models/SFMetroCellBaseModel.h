//
//  SFMetroCellBaseModel.h
//  MetroUIDemo
//
//  Created by 郑庆登(King Zheng)-企业内部系统研发中心 on 2018/7/18.
//  Copyright © 2018年 sinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,SFMetroCellWidthType){
    SFMetroCellWidthTypeMinor     = 0,   // 小
    SFMetroCellWidthTypeMedium    = 1,  //  中
    SFMetroCellWidthTypeFull      = 2,  //  大
};
@interface SFMetroCellBaseModel : NSObject
@property(nonatomic,copy)NSString* cellClass;// cell类
@property(nonatomic,assign)SFMetroCellWidthType widthType;
@property(nonatomic,copy)NSString* subjectName;
@property(nonatomic,copy)NSString* subjectImg;
@property(nonatomic,assign)NSInteger badgeNum;
@property(nonatomic,strong)UIColor* backgroundColor;
@end
