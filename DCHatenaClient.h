//
//  DCHatenaClient.h
//  earth
//
//  Created by 長 大地 on 09/08/16.
//  Copyright 2009 Daichi Cho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCAtomPubClient.h"

@interface DCHatenaClient : DCAtomPubClient {

}

- (void)post:(NSString *)bookmarkURL comment:(NSString *)comment;
- (void)edit:(NSString *)eid title:(NSString *)title comment:(NSString *)comment;
- (void)delete:(NSString *)eid;

@end
