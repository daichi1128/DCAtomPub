//
//  DCHatenaPostClient.h
//  DCAtomPub
//
//  Created by 長 大地 on 09/08/16.
//  Copyright 2009 Daichi Cho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCWSSEURLRequest.h"

@protocol DCAtomPubDelegate;

@interface DCAtomPubClient : NSObject {
	id<DCAtomPubDelegate> delegate;
	DCWSSEURLRequest *request;
	NSString *username;
	NSString *password;

	NSURLConnection *_con;	
	NSMutableData *_data;
}

@property (nonatomic, retain) id<DCAtomPubDelegate> delegate;
@property (nonatomic, retain) DCWSSEURLRequest *request;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

- (id)initWithUsername:(NSString *)username password:(NSString *)password;
- (NSData *)synchronousPost:(NSString *)URL XMLString:(NSString *)XMLString httpMethod:(NSString *)httpMethod;
- (void)post:(NSString *)URL XMLString:(NSString *)XMLString httpMethod:(NSString *)httpMethod;
- (void)post:(NSString *)URL XMLString:(NSString *)XMLString;
- (void)put:(NSString *)URL XMLString:(NSString *)XMLString;
- (void)delete:(NSString *)URL XMLString:(NSString *)XMLString;

@end

@protocol DCAtomPubDelegate <NSObject>

@optional

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection data:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

@end

