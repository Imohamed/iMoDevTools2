//
//  UIAlertView+Blocks.m
//  UIAlertViewBlocks
//
//  Created by Ryan Maxwell on 29/08/13.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Ryan Maxwell
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "NSURLConnection+background.h"

@implementation NSURLConnection (Background)
+ (void)sendSynchronousRequest:(NSURLRequest *)request inBackgroundWithCompletionHandler:(void (^)(NSURLResponse*, NSData*, NSError*))handler {
    
    dispatch_async(dispatch_queue_create
                   ("AsynchRequest", NULL), ^{
                       NSURLResponse *response = nil;
                       NSError *error = nil;
                       NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                       
                       dispatch_sync(dispatch_get_main_queue(), ^{
                           handler(response,data,error);
                       });
                   });
}
@end
