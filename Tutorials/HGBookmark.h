//
//  HGBookmark.h
//  UP Studio
//
//  Created by gjh on 2017/2/6.
//  Copyright © 2017年 TierTime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGBookmark : NSObject
+ (HGBookmark *)defaultShareBookmark;


/**
 保存打开文件的URL到bookmark中 
 
 bookmark:可以对应用中打开的文件或文件夹在以后永久性访问而不需要再次通过NSOpenPanel打开
 
 @param filePath 打开的文件路径

 @return  成功或者失败
 */
-(BOOL)saveOpenFileToBookmarkWithFilePath:(NSString *)filePath;



/**
 移除Bookmark  保存的记录
 
 @param filePath 根据路径找到记录删除
 
 */
-(BOOL)removeFileBookmarkInfoWithFilePath:(NSString *)filePath;


/**
 开始安全访问
 
 @param filePath 访问的文件路径
 
 */
-(BOOL)BookmarkStartAccessingSecurityScopedResourceWithFilePath:(NSString *)filePath;


/**
 停止安全访问
 
 @param filePath 访问的文件路径
 
 */
-(BOOL)BookmarkStopAccessingSecurityScopedResourceWithFilePath:(NSString *)filePath;
@end
