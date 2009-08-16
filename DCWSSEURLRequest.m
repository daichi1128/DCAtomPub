//
//  DCWSSEURLRequest.m
//  DCAtomPub
//
//  Created by 長 大地 on 09/08/16.
//  Copyright 2009 Daichi Cho. All rights reserved.
//

#import "DCWSSEURLRequest.h"
#import "DCWSSE.h"

@implementation DCWSSEURLRequest

- (id)initWithUsername:(NSString *)username password:(NSString *)password {
	if (self = [super init]){
		[self setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
		[self setTimeoutInterval:20];
		[self setValue:[DCWSSE wsseString:username password:password] forHTTPHeaderField:@"X-WSSE"];		
	}
	return self;
}

@end
