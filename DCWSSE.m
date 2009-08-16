//
//  DCWSSE.m
//  earth
//
//  Created by 長 大地 on 09/08/16.
//  Copyright 2009 Daichi Cho. All rights reserved.
//

#import "DCWSSE.h"
#import "CocoaCryptoHashing.h"
#import "Base64EncDec.h"


@implementation DCWSSE

+ (NSString *)wsseString:(NSString *)username password:(NSString *)password {
	
	NSString *passwordDigest;
	NSString *nonce;
	NSString *created;
	
	NSDate *now = [NSDate date];
	NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
	[df setDateFormat:@"yyyy-MM-dd'T'HH:mm:sszzz"];
	[df setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"US"] autorelease]];
	created = [df stringFromDate:now];
	
	srand(time(nil));
	NSString *tmpNonce = 
    [[NSString stringWithFormat:@"%@%d", created, rand()] sha1HexHash];
	passwordDigest = [[[NSString stringWithFormat:@"%@%@%@",
						tmpNonce, created, password] sha1Hash] stringEncodedWithBase64];
	nonce = [[tmpNonce dataUsingEncoding:NSASCIIStringEncoding] stringEncodedWithBase64];
	return [NSString stringWithFormat:
			@"UsernameToken Username=\"%@\", PasswordDigest=\"%@\", Nonce=\"%@\", Created=\"%@\"", 
			username, passwordDigest, nonce, created];
	
}

@end
