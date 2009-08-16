//
//  DCHatenaClient.m
//  DCAtomPub
//
//  Created by 長 大地 on 09/08/16.
//  Copyright 2009 Daichi Cho. All rights reserved.
//

#import "DCHatenaClient.h"


@implementation DCHatenaClient

- (void)post:(NSString *)bookmarkURL comment:(NSString *)comment {
	NSString *hatenaPostURL = @"http://b.hatena.ne.jp/atom/post";
	
	NSString *postXMLTemplate = 
	@"<entry xmlns=\"http://purl.org/atom/ns#\">"
	@"<link rel=\"related\" type=\"text/html\" href=\"%@\" />"
	@"<summary type=\"text/plain\">%@</summary>"
	@"</entry>";
	
	[self post:hatenaPostURL XMLString:[NSString stringWithFormat:postXMLTemplate, bookmarkURL, comment]];
}

- (void)edit:(NSString *)eid title:(NSString *)title comment:(NSString *)comment {
	if (!eid) {
		NSAssert(YES,@"エントリIDは必須です。");
		return;
	}
	
	if (!title && !comment) {
		NSAssert(YES,@"タイトルとコメントはいずれか必須です。");
		return;
	}
	
	NSString *hatenaEditURL = [NSString stringWithFormat:@"http://b.hatena.ne.jp/atom/edit/%@",eid];
	NSString *editXMLTemplate = 
		@"<entry xmlns=\"http://purl.org/atom/ns#\">"
		@"%@"
		@"</entry>";
	
	NSString *titleTemplate = @" <title>%@</title>";
	NSString *commentTemplate = @"<summary type=\"text/plain\">%@</summary>";
	NSMutableString *insertString = [[[NSMutableString alloc] init] autorelease];
	
	if (title) {
		[insertString appendString:[NSString stringWithFormat:titleTemplate, title]];
	}
	if (comment) {
		[insertString appendString:[NSString stringWithFormat:commentTemplate, comment]];
	}
		
	[self put:hatenaEditURL XMLString:[NSString stringWithFormat:editXMLTemplate, insertString]];
}

- (void)delete:(NSString *)eid {
	if (!eid) {
		NSAssert(YES,@"エントリIDは必須です。");
		return;
	}
	
	NSString *hatenaDeleteURL = [NSString stringWithFormat:@"http://b.hatena.ne.jp/atom/edit/%@",eid];	
	[self delete:hatenaDeleteURL XMLString:nil];
}

@end
