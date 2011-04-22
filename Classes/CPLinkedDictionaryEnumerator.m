//
//  CPLinkedDictionaryEnumerator.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-20.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPLinkedDictionaryEnumerator.h"


@implementation CPLinkedDictionaryEnumerator

+(NSEnumerator *)enumeratorWithSentinel:(CPLinkedMapNode *)sentinelNode {
	return [[[CPLinkedDictionaryEnumerator alloc] initWithSentinel:sentinelNode] autorelease];
}

-(id)initWithSentinel:(CPLinkedMapNode *)sentinelNode {
	if ((self = [super init])) {
		sentinel = sentinelNode;
		currentNode = sentinelNode;
	}
	return self;
}

-(BOOL)hasNext {
	return currentNode.next != sentinel;
}

-(id)nextObject {
	if ([self hasNext]) {
		currentNode = currentNode.next;
		return currentNode;
	}
	return nil;
	
}

@end
