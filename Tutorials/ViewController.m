//
//  ViewController.m
//  Tutorials
//
//  Created by gjh on 2017/1/17.
//  Copyright © 2017年 gjh. All rights reserved.
//

#import "ViewController.h"

#import "HGBookmark.h"
@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 测试最近打开的文件路径
    NSString *testPath = @"/Users/gjh/Desktop/DeskTopTest.txt";
    BOOL isStartAcces =  [[HGBookmark defaultShareBookmark]BookmarkStartAccessingSecurityScopedResourceWithFilePath:testPath];
    if (isStartAcces) {
        NSURL *fileURL = [NSURL fileURLWithPath:testPath];
        [[NSWorkspace sharedWorkspace]openURL:fileURL];
        [[HGBookmark defaultShareBookmark]BookmarkStopAccessingSecurityScopedResourceWithFilePath:testPath];
    }
    
    
    NSOpenPanel *openDlg = [NSOpenPanel openPanel];
    
    openDlg.canChooseFiles = YES ;
    
    openDlg.canChooseDirectories = YES;
    
    openDlg.allowsMultipleSelection = YES;
    
    openDlg.allowedFileTypes = @[@"txt"];
    
    
    
    [openDlg beginWithCompletionHandler: ^(NSInteger result){
        
        if(result==NSFileHandlingPanelOKButton){
            
            NSArray *fileURLs = [openDlg filenames];
            
            for(NSURL *url in fileURLs) {
                
                NSString *filePath = [fileURLs objectAtIndex : 0];
                [[HGBookmark defaultShareBookmark]saveOpenFileToBookmarkWithFilePath:filePath];
                NSURL *urlfile = [NSURL fileURLWithPath:filePath];
                [[NSWorkspace sharedWorkspace]openURL:urlfile];
            }
        }
    }];
    
}




- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}


@end
