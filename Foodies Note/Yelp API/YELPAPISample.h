//
//  YELPAPISample.h
//  GebeChat
//
//  Created by Siba Prasad Hota  on 1/5/15.
//  Copyright (c) 2015 WemakeAppz. All rights reserved.
//

//3rd part code
#import <Foundation/Foundation.h>

@interface YELPAPISample : NSObject

- (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path;
-(NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)params;


- (void)getServerResponseForLocation:(NSString *)location
                                term:(NSString*)term
                           iSLonglat:(BOOL)longlat
                 withSuccessionBlock:(void(^)(NSDictionary * topBusinessJSON))successBlock
                     andFailureBlock:(void(^)(NSError *error))failureBlock;

@end
