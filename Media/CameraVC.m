//
//  CameraVC.m
//  Media
//
//  Created by 刘清 on 16/5/27.
//  Copyright © 2016年 LQ. All rights reserved.
//

#import "CameraVC.h"

@interface CameraVC () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//相册
- (IBAction)photo:(id)sender {
    
    [self getImageBySocuce:NO];
    
}
//相机
- (IBAction)camera:(id)sender {
    
    //判断支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self getImageBySocuce:YES];
    }else{
        NSLog(@"该设备不支持相机");
    }
    
    
}

//调用图片方法
//isCamera   YES --> 相机   NO --> 相册
- (void)getImageBySocuce:(BOOL)isCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //指定图片源
    if (isCamera) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //指定代理
    picker.delegate = self;
    //推出界面
    [self presentViewController:picker animated:YES completion:nil];
}

//回传选中的照片数据
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%@", info);
    //传回的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //将图片赋给imageview
    _imageView.image = image;
    
    //返回上一个界面
    [picker dismissViewControllerAnimated:YES completion:nil];
 
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
