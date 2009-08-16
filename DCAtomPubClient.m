//
//  DCHatenaPostClient.m
//  earth
//
//  Created by 長 大地 on 09/08/16.
//  Copyright 2009 Daichi Cho. All rights reserved.
//

#import "DCAtomPubClient.h"
#import "DCWSSEURLRequest.h"

@implementation DCAtomPubClient

@synthesize delegate, request, username, password;

#pragma mark -
#pragma mark NSObject

- (id) init
{
	self = [super init];
	if (self != nil) {
		delegate = nil;
		username = nil;
		password = nil;
		request = nil;
		_con = nil;
		_data = nil;
	}
	return self;
}

- (void) dealloc
{
	[delegate release];
	[username release];
	[password release];
	[request release];
	[_con release];
	[_data release];
	[super dealloc];
}


#pragma mark -
#pragma mark DCAtomAPIClient

- (id)initWithUsername:(NSString *)aUsername password:(NSString *)aPassword {
	if (self = [super init]) {
		self.username = aUsername;
		self.password = aPassword;
		self.request = [[[DCWSSEURLRequest alloc] initWithUsername:aUsername password:aPassword] autorelease];
	}
	return self;
}

- (void)post:(NSString *)URL XMLString:(NSString *)XMLString {
	[self post:URL XMLString:XMLString httpMethod:@"POST"];
}

- (void)put:(NSString *)URL XMLString:(NSString *)XMLString {
	[self post:URL XMLString:XMLString httpMethod:@"PUT"];
}

- (void)delete:(NSString *)URL XMLString:(NSString *)XMLString {
	[self post:URL XMLString:XMLString httpMethod:@"DELETE"];
}

#pragma mark -
#pragma mark private method

-(NSData *)synchronousPost:(NSString *)URL XMLString:(NSString *)XMLString httpMethod:(NSString *)httpMethod{
	NSError *error;
	NSHTTPURLResponse *response;
	
	[request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:httpMethod];
	[request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:[XMLString dataUsingEncoding:NSUTF8StringEncoding]];
	
	
	return [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
}

-(void)post:(NSString *)URL XMLString:(NSString *)XMLString httpMethod:(NSString *)httpMethod{
	[request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:httpMethod];
	[request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:[XMLString dataUsingEncoding:NSUTF8StringEncoding]];
	
	_con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	_data = nil;
	_data = [[NSMutableData alloc] init];
	
	if ([delegate respondsToSelector:@selector(connection:didReceiveResponse:)]) {
		[delegate connection:connection didReceiveResponse:response];
	}	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[_data appendData:data];
	
	if ([delegate respondsToSelector:@selector(connection:didReceiveData:)]) {
		[delegate connection:connection didReceiveData:data];
	}		
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	if ([delegate respondsToSelector:@selector(connectionDidFinishLoading:data:)]) {
		[delegate connectionDidFinishLoading:connection data:_data];
	}
	[_data release];
	_data = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	if ([delegate respondsToSelector:@selector(connection:didFailWithError:)]) {
		[delegate connection:connection didFailWithError:error];
	}		
}

@end
