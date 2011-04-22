//
//  CPLinkedListEnumerator.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-20.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPLinkedListEnumerator.h"


@implementation CPLinkedListEnumerator

+(NSEnumerator *)enumeratorWithSentinel:(CPLinkedNode *)sentinelNode {
	return [[[CPLinkedListEnumerator alloc] initWithSentinel:sentinelNode] autorelease];
}

-(id)initWithSentinel:(CPLinkedNode *)sentinelNode {
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
		return currentNode.element;
	}
	return nil;
		
}


@end
