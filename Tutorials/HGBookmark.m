//
//  HGBookmark.m
//  UP Studio
//
//  Created by gjh on 2017/2/6.
//  Copyright © 2017年 TierTime. All rights reserved.
//  处理最近打开的逻辑
//

#import "HGBookmark.h"
static HGBookmark *instance = nil;
@implementation HGBookmark

+(HGBookmark *)defaultShareBookmark
{
    if (instance == nil) {
        instance = [[HGBookmark alloc]init];
    }
    return instance;
}


/**
 保存开发文件的BookMark  到记录中

 @param filePath 文件路径为保存的标志

 */
-(BOOL)saveOpenFileToBookmarkWithFilePath:(NSString *)filePath
{
    BOOL isSuccess = NO;
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    NSError *error;
    NSData *bookmarkData = [fileURL bookmarkDataWithOptions:NSURLBookmarkCreationWithSecurityScope
                         includingResourceValuesForKeys:nil
                                          relativeToURL:nil
                                                  error:&error];
    if (bookmarkData != nil) {
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //保存文件路径
        [defaults setObject:bookmarkData forKey:filePath];
        [defaults synchronize];
        isSuccess = YES;
    }
    return isSuccess;
}


/**
 开始安全访问

 @param filePath 访问的文件路径

 */
-(BOOL)BookmarkStartAccessingSecurityScopedResourceWithFilePath:(NSString *)filePath
{
    BOOL isSuccess = NO;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *bookmarkData =  [defaults objectForKey:filePath];
    if (bookmarkData !=nil) {
        BOOL isStale;
        NSURL *allowedUrl = [NSURL URLByResolvingBookmarkData:bookmarkData
                                                      options:NSURLBookmarkResolutionWithSecurityScope
                                                relativeToURL:nil
                                          bookmarkDataIsStale:&isStale
                                                        error:NULL];
        if (allowedUrl) {
             isSuccess =[allowedUrl startAccessingSecurityScopedResource];
        }
    }
      return isSuccess;
}


/**
 停止安全访问

 @param filePath 访问的文件路径

 */
-(BOOL)BookmarkStopAccessingSecurityScopedResourceWithFilePath:(NSString *)filePath
{
    BOOL isSuccess = NO;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *bookmarkData =  [defaults objectForKey:filePath];
    if (bookmarkData !=nil) {
        BOOL isStale;
        NSURL *allowedUrl = [NSURL URLByResolvingBookmarkData:bookmarkData
                                                      options:NSURLBookmarkResolutionWithSecurityScope
                                                relativeToURL:nil
                                          bookmarkDataIsStale:&isStale
                                                        error:NULL];
        if (allowedUrl) {
            [allowedUrl stopAccessingSecurityScopedResource];
            isSuccess = YES;
        }
    }
    return isSuccess;

}



/**
 移除Bookmark  保存的记录

 @param filePath 根据路径找到记录删除

 */
-(BOOL)removeFileBookmarkInfoWithFilePath:(NSString *)filePath
{
    BOOL isSuccess = NO;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id obj = [defaults objectForKey:filePath];
    if (obj) {
        [defaults removeObjectForKey:filePath];
        isSuccess = YES;
    }
    return isSuccess;
}


@end
