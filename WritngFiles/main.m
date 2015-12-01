//
//  main.m
//  WritngFiles
//
//  Created by 张润峰 on 15/12/1.
//  Copyright © 2015年 张润峰. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableString *str = [[NSMutableString alloc] init];
        for (int i = 0; i < 10; i++) {
            [str appendString:@"hello\n"];
        }
        
        //将NSString写入文件
        NSError *error = nil;
        BOOL success = [str writeToFile:@"/tmp/cool.txt"
              atomically:YES
                encoding:NSUTF8StringEncoding
                   error:&error];
        if (success) {
            NSLog(@"done writing /tmp/cool.txt");
        } else {
            NSLog(@"writing /tmp/cool.txt failed:%@", [error localizedDescription]);
        }
        
        //从指定文件读取内容
        NSString *readedStr = [[NSString alloc]
                               initWithContentsOfFile:@"/tmp/cool.txt"
                                             encoding:NSASCIIStringEncoding
                                               error:&error];
        if (!str) {
            NSLog(@"read failed: %@", [error localizedDescription]);
        }else {
            NSLog(@"read file /tmp/cool.txt success! The content is:\n%@", readedStr);
        }
        
        //将NSData对象所保存的数据写入文件
        NSURL *url = [NSURL URLWithString:@"http://n.sinaimg.cn/transform/20150605/HqMW-crvvpkk7973326.jpg"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:NULL
                                                         error:&error];
        if (!data) {
            NSLog(@"fetch failed :%@", [error localizedDescription]);
            return 1;
        }
        
        NSLog(@"The file is %lu bytes", [data length]);
        
        BOOL written = [data writeToFile:@"/tmp/ios.jpg"
                              options:NSDataWritingAtomic
                                   error:&error];
        if (!written) {
            NSLog(@"write failed: %@", [error localizedDescription]);
            return 1;
        }
        
        NSLog(@"Success!");
        
        //从文件读取数据并存入NSData对象
        NSData *readedData = [NSData dataWithContentsOfFile:@"/tmp/ios.jpg"];
        NSLog(@"The file read from the disk has %lu bytes", [readedData length]);
    }
    return 0;
}
