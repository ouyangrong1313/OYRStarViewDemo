//
//  OYRStarView.h
//  OYRStarViewDemo
//
//  Created by 欧阳荣 on 2021/3/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, OYRStarType) {
    OYRStarTypeInteger = 0, // 整数
    OYRStarTypeFloat, // 允许浮点（半颗星）
};

@interface OYRStarView : UIView

@property (nonatomic, copy) void(^starBlock)(NSString *value);

@property (nonatomic, assign) CGFloat star;

@property (nonatomic, assign) BOOL isTouch;

- (instancetype)initWithFrame:(CGRect)frame
                     starSize:(CGSize)starSize
                    withStyle:(OYRStarType)style
                      starNum:(NSInteger)starNum;

@end

NS_ASSUME_NONNULL_END
