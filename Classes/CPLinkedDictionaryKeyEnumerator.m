//
//  CPLinkedDictionaryKeyEnumerator.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-20.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPLinkedDictionaryKeyEnumerator.h"


@implementation CPLinkedDictionaryKeyEnumerator

+(NSEnumerator *)enumeratorWithSentinel:(CPLinkedMapNode *)sentinelNode {
	return [[[CPLinkedDictionaryKeyEnumerator alloc] initWithSentinel:sentinelNode] autorelease];
}

-(id)nextObject {
	id node = [super nextObject];
	return node != nil ? ((CPLinkedMapNode *)node).key : nil;
}

@end
