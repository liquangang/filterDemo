//
//  ViewController.m
//  tutuTest
//
//  Created by liquangang on 2017/3/29.
//  Copyright © 2017年 必要. All rights reserved.
//

#import "ViewController.h"
#import <TuSDKGeeV1/TuSDKGeeV1.h>
#import <TuSDKGeeV2/TuSDKGeeV2.h>
#import <TuSDK/TuSDK.h>
#import "GeeV2Sample.h"
#import "EditFilterSampleController.h"

static const CGFloat screenHeight(){
    return [UIScreen mainScreen].bounds.size.height;
}

static const CGFloat screenWidth(){
    return [UIScreen mainScreen].bounds.size.width;
}

@interface ViewController ()
<
    TuSDKFilterManagerDelegate,
    TuSDKPFEditFilterControllerDelegate
>

@property (nonatomic, strong) UIButton *photoLibraryButton; /**> 照片美化button*/
@property (nonatomic, strong) GeeV2Sample *geeV2Sample;     /**> 照片美化组件*/
@property (nonatomic, strong) UIButton *editFiterButton;    /**> 滤镜编辑button*/
@property (nonatomic, strong) UIImageView *originImageView; /**> 原图*/
@property (nonatomic, strong) UIImageView *finishImageView; /**> 渲染完成的图*/
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self tuSDKInit];
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TuSDKFilterManagerDelegate

- (void)onTuSDKFilterManagerInited:(TuSDKFilterManager *)manager;
{
    // 可以将方法去掉，不进行初始化完成的提示
    [self showHubSuccessWithStatus:LSQString(@"lsq_inited", @"初始化完成")];
}

#pragma mark - TuSDKPFEditFilterControllerDelegate

/**
 *  图片编辑完成
 *
 *  @param controller 图片编辑滤镜控制器
 *  @param result 处理结果
 */
- (void)onTuSDKPFEditFilter:(TuSDKPFEditFilterController *)controller result:(TuSDKResult *)result{
    self.finishImageView.image = result.image;
}

#pragma mark - interface

- (void)tuSDKInit{
    
    // 启动GPS，图片中会包含对应的地理位置的信息
    [[TuSDKTKLocation shared] requireAuthorWithController:self];
    
    // 异步方式初始化滤镜管理器
    // 需要等待滤镜管理器初始化完成，才能使用所有功能
    [self showHubWithStatus:LSQString(@"lsq_initing", @"正在初始化")];
    [TuSDK checkManagerWithDelegate:self];
    
    // 用户可以通过打印字段的方式获取到正在使用的 SDK 的版本号
    NSLog(@"版本号 : %@",lsqSDKVersion);
}

- (void)setUI{
//    [self.view addSubview:self.photoLibraryButton];
    [self.view addSubview:self.editFiterButton];
    [self.view addSubview:self.originImageView];
    [self.view addSubview:self.finishImageView];
}

#pragma mark - 点击方法

- (void)photoLibraryButtonAction{
    [self.geeV2Sample showSampleWithController:self];
}

- (void)editFiterButtonAction{
    EditFilterSampleController *editFilterVc = [EditFilterSampleController new];
    editFilterVc.delegate = self;
    editFilterVc.inputImage = self.originImageView.image;
    [self pushViewController:editFilterVc animated:YES];
}

#pragma mark - 懒加载

- (UIButton *)photoLibraryButton{
    if (!_photoLibraryButton) {
        UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 50)];
        [tempButton addTarget:self action:@selector(photoLibraryButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [tempButton setTitle:@"照片美化" forState:UIControlStateNormal];
        [tempButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _photoLibraryButton = tempButton;
    }
    return _photoLibraryButton;
}

- (GeeV2Sample *)geeV2Sample{
    if (!_geeV2Sample) {
        _geeV2Sample = [GeeV2Sample sample];
    }
    return _geeV2Sample;
}

- (UIButton *)editFiterButton{
    if (!_editFiterButton) {
        UIButton *tempBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 100, 100, 50)];
        [tempBtn addTarget:self action:@selector(editFiterButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [tempBtn setTitle:@"滤镜编辑" forState:UIControlStateNormal];
        [tempBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _editFiterButton = tempBtn;
    }
    return _editFiterButton;
}

- (UIImageView *)originImageView{
    if (!_originImageView) {
        UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 160, screenWidth(), (screenHeight() - 100) / 2 - 10)];
        tempImageView.image = [UIImage imageNamed:@"meiyan"];
        tempImageView.contentMode = UIViewContentModeScaleAspectFit;
        tempImageView.clipsToBounds = YES;
        _originImageView = tempImageView;
    }
    return _originImageView;
}

- (UIImageView *)finishImageView{
    if (!_finishImageView) {
        UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.originImageView.frame), screenWidth(), CGRectGetHeight(self.originImageView.frame))];
        tempImageView.contentMode = UIViewContentModeScaleAspectFit;
        tempImageView.backgroundColor = [UIColor grayColor];
        tempImageView.clipsToBounds = YES;
        _finishImageView = tempImageView;
    }
    return _finishImageView;
}

@end
