//
//  AppDelegate.m
//  DCAtomPub
//
//  Created by Daichi Cho on 09/08/16.
//  Copyright Daichi Cho 2009. All rights reserved.
//

#import "AppDelegate.h"
#import "DCWSSE.h"
#import "DCHatenaClient.h"

@interface DummyDelegate : NSObject <DCAtomPubDelegate>{}
@end

@implementation DummyDelegate
- (void)connectionDidFinishLoading:(NSURLConnection *)connection data:(NSData *)data {
	NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(responseBody);
}
@end


@implementation AppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

	// ユーザ名
	NSString *username = @"username";
	// パスワード
	NSString *password = @"password";
	
	
	// WSSE認証文字列の生成
	NSLog([DCWSSE wsseString:username password:password]);
	
	/** 
	 * はてなブックマーク用クライアントではてなブックマークを追加
	 */
	DCHatenaClient *hatenaClient = [[DCHatenaClient alloc] initWithUsername:username password:password];
	hatenaClient.delegate = [[[DummyDelegate alloc] init] autorelease];
	
	[hatenaClient post:@"http://iphone.longearth.net" comment:@"DCHatenaClientから"];
	// 追加完了
	

	// はてなブックマークの編集
	//	[hatenaClient edit:@"{エントリーID}" title:@"変更後のタイトル" comment:@"変更後のコメント"];
	
	// はてなブックマークの削除
	//	[hatenaClient delete:@"{エントリーID}"];
	
	
	
	/** 
	 *AtomPubクライアントではてなブックマークを追加
	 */
	DCAtomPubClient *atomClient = [[DCAtomPubClient alloc] initWithUsername:username password:password];
	
	NSString *hatenaPostURL = @"http://b.hatena.ne.jp/atom/post";
	NSString *postXMLTemplate = 
	@"<entry xmlns=\"http://purl.org/atom/ns#\">"
	@"<link rel=\"related\" type=\"text/html\" href=\"%@\" />"
	@"<summary type=\"text/plain\">%@</summary>"
	@"</entry>";
	
	// POSTメソッドでXMLを送信
	[atomClient post:hatenaPostURL XMLString:[NSString stringWithFormat:
											  postXMLTemplate, 
											  @"http://iphone.longearth.net/itasktimer/",@"DCAtomPubから"
											  ]];
	// 追加完了
	// PUTメソッドでXMLを送信
//	[atomClient put:@"" XMLString:@""];
	
	// DELETEメソッドでXMLを送信
//	[atomClient delete:@"" XMLString:@""];
	


	
/**
 ブックマーク追加のレスポンスに含まれる以下のhref="atom/edit/15351539"の15351539がエントリーID
 <link rel="service.edit" type="application/x.atom+xml" href="atom/edit/15351539" title="iphoneアプリで稼げるのか" />
 
 はてなAPIの詳細は以下を参照
 http://d.hatena.ne.jp/keyword/%A4%CF%A4%C6%A4%CA%A5%D6%A5%C3%A5%AF%A5%DE%A1%BC%A5%AFAtomAPI
 
 */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
