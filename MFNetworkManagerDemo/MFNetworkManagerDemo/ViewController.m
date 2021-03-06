//
//  ViewController.m
//  MFNetworkManagerDemo
//
//  Created by pipelining on 2018/2/26.
//  Copyright © 2018年 pipelining. All rights reserved.
//

#import "ViewController.h"
#import "MFNetworkManager.h"
#import "DisplayResultViewController.h"
@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *list;
@end

@implementation ViewController

- (NSArray *)list {
    if (!_list) {
        _list = @[
                  @"get",
                  @"post",
                  @"put",
                  @"delete",
                  @"upload",
                  @"download"
                  ];
    }
    return _list;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"NetworkManager";
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:@"add" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    self.navigationItem.rightBarButtonItem = add;
}

- (void)add:(UIBarButtonItem *)sender {
    [MFNETWROK setValue:@"headerfield_value" forHTTPHeaderField:@"headerfield_key"];
    [MFNETWROK setValue:@"commonparams_value" forParameterField:@"commonparams_key"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    cell.textLabel.text = self.list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DisplayResultViewController *display = [[DisplayResultViewController alloc] init];
    display.type = indexPath.row;
    if (indexPath.row == 4) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes = @[
                              (NSString *)kUTTypeImage
                              ];
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        [self.navigationController pushViewController:display animated:YES];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    DisplayResultViewController *display = [[DisplayResultViewController alloc] init];
    display.type = 2;
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (@available(iOS 11.0, *)) {
        NSString *url = [info objectForKey:UIImagePickerControllerImageURL];
        if ([url.pathExtension isEqualToString:@"gif"]) {
            display.imageType = MFImageTypeGIF;
        }else if ([url.pathExtension isEqualToString:@"jpeg"]) {
            display.imageType = MFImageTypeJPEG;
        }else if ([url.pathExtension isEqualToString:@"png"]) {
            display.imageType = MFImageTypePNG;
        }else if ([url.pathExtension isEqualToString:@"tiff"]) {
            display.imageType = MFImageTypeTIFF;
        }else {
            display.imageType = MFImageTypeUNKNOWN;
        }
    }
    display.imageList = [@[image] mutableCopy];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.navigationController pushViewController:display animated:YES];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{
       
    }];
}

@end
