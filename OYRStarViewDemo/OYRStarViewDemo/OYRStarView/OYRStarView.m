//
//  OYRStarView.m
//  OYRStarViewDemo
//
//  Created by 欧阳荣 on 2021/3/29.
//

#import "OYRStarView.h"

#define WHITE_NAME @"Week_Star_Normal"
#define RED_NAME @"Week_Star_Highlight"

@interface OYRStarView ()

@property (nonatomic, assign) OYRStarType starType;

@property (nonatomic, assign) CGSize starSize;

@property (nonatomic, strong) NSMutableArray *starArray;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat lineMargin;

@property (nonatomic, assign) CGFloat listMargin;

@property (nonatomic, strong) UIView *foreView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, assign) NSInteger starNum;

@end

@implementation OYRStarView

- (instancetype)initWithFrame:(CGRect)frame starSize:(CGSize)starSize withStyle:(OYRStarType)style starNum:(NSInteger)starNum {
    if (self = [super initWithFrame:frame]) {
        self.starType = style;
        self.starSize = starSize;
        self.isTouch = YES;
        self.starNum = starNum;
        [self initViewStar];
    }
    return  self;
}

- (void)initViewStar {
    self.starArray = [NSMutableArray array];
    CGFloat width;
    CGFloat height;
    CGFloat lineMargin;
    CGFloat listMargin;
    if (self.starSize.width == 0 || self.starSize.width > self.frame.size.width / self.starNum) {
        width = self.frame.size.width / (self.starNum + self.starNum - 2);
        if (width > self.frame.size.height) {
            width = self.frame.size.height;
        }
        height = width;
        lineMargin = MAX(0, (self.frame.size.height - height) / 2.0);
        listMargin = (self.frame.size.width - self.starNum * width) / self.starNum;
    }else {
        width = self.starSize.width;
        if (width > self.frame.size.height) {
            width = self.frame.size.height;
        }
        height = self.starSize.height > self.frame.size.height ? width : self.starSize.height;
        lineMargin = MAX((self.frame.size.height - height) / 2.0, 0);
        listMargin = (self.frame.size.width - width * self.starNum) / self.starNum;
    }
    self.width = width;
    self.height = height;
    self.lineMargin = lineMargin;
    self.listMargin = listMargin;
    if (self.starType == OYRStarTypeInteger) {
        for (int i = 0; i < self.starNum; i ++) {
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:RED_NAME]];
            imgView.frame = CGRectMake(i * (width + listMargin) + listMargin / 2.0, lineMargin, width, height);
            [self addSubview:imgView];
            [self.starArray addObject:imgView];
        }
    }else {
        [self initForFloatStar];
    }
}

- (void)initForFloatStar {
    self.foreView = [self createViewWithImageName:RED_NAME withFlag:YES];
    self.bgView = [self createViewWithImageName:WHITE_NAME withFlag:NO];
    [self addSubview:self.bgView];
    [self addSubview:self.foreView];
}

- (UIView *)createViewWithImageName:(NSString *)name withFlag:(BOOL)flag {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < self.starNum; i ++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
        imgView.frame = CGRectMake(i * (self.width + self.listMargin) + self.listMargin / 2.0, self.lineMargin, self.width, self.height);
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imgView];
        if (flag) {
            [self.starArray addObject:imgView];
        }
    }
    return view;
}

- (void)setStar:(CGFloat)star {
    star = MAX(0, MIN(self.starNum, star));
    _star = self.starType == 0 ? (int)star : star;
    if (self.starType == 0) {
        _star = _star == 0 ? 1 : _star;
        [self.starArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *img = obj;
            if (idx + 1 < star) {
                img.image = [UIImage imageNamed:RED_NAME];
            }else {
                img.image = [UIImage imageNamed:WHITE_NAME];
            }
        }];
    }else {
        int value = star;
        CGFloat width = (value) * (self.width + self.listMargin) + self.listMargin / 2.0 + (star - value) * self.width;
        self.foreView.frame = CGRectMake(0, 0, width, self.frame.size.height);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.isTouch) {
        return;
    }
    if (self.starType == OYRStarTypeInteger) {
        [self resetIntegerStar:touches];
    }else {
        [self resetFloatStar:touches];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.isTouch) {
        return;
    }
    if (self.starType == OYRStarTypeInteger) {
        [self resetIntegerStar:touches];
    }else {
        [self resetFloatStar:touches];
    }
}

- (void)resetFloatStar:(NSSet<UITouch *> *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self]; // touchPoint    CGPoint    (x = 132, y = 24)
    CGPoint starPoint; // starPoint    CGPoint    (x = 2.159851630388001E-314, y = 2.1433152640911387E-314)
    int flag = 0; // 判断是否已经调用block；
    CGFloat star = 0;
    if (touchPoint.x >= 0 && touchPoint.x < self.frame.size.width && touchPoint.y >= 0 && touchPoint.y < self.frame.size.height) {
        for (int i = 0; i < self.starNum; i ++) {
            UIImageView *img = self.starArray[i];
            starPoint = [touch locationInView:img]; // starPoint    CGPoint    (x = 125.33333333333333, y = 17.333333333333314) -- (x = 6.8333333333333428, y = 10.333333333333314)
            if (starPoint.x >= 0 && starPoint.x <= self.width) { // _width    CGFloat    16.666666666666668
                CGFloat value = starPoint.x / self.width; // value    CGFloat    0.41000000000000053
                self.foreView.frame = CGRectMake(0, 0, img.frame.origin.x + value * self.width, self.frame.size.height);
                if (flag == 0 && self.starBlock) {
                    self.starBlock([NSString stringWithFormat:@"当前星星数：%.1f",i + value]);
                }
                flag ++;
            }else {
                self.foreView.frame = CGRectMake(0, 0, touchPoint.x, self.frame.size.height);
                if (touchPoint.x > img.frame.origin.x) {
                    star = i + 1;
                }
            }
        }
        if (flag == 0 && self.starBlock) { // 没有调用block，当前点击不在星星上；
            self.starBlock([NSString stringWithFormat:@"当前点击不在星星上：%.1f",star]);
        }
    }
}

- (void)resetIntegerStar:(NSSet<UITouch *> *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self]; // touchPoint    CGPoint    (x = 204, y = 16)
    NSInteger star = 0;
    for (int i = 0; i < self.starNum; i ++) {
        UIImageView *img = self.starArray[i];
        if (touchPoint.x >= 0 && touchPoint.x < self.frame.size.width && touchPoint.y >= 0 && touchPoint.y < self.frame.size.height) {
            if (img.frame.origin.x > touchPoint.x) {
                img.image = [UIImage imageNamed:WHITE_NAME];
            }else {
                img.image = [UIImage imageNamed:RED_NAME];
                star ++;
            }
        }
    }
    if (self.starBlock) {
        self.starBlock([NSString stringWithFormat:@"我有 %ld 颗星星啦~",(long)star]);
    }
}

@end
