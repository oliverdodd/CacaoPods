//
//  CPLinkedListEnumerator.m
//  CacaoPods
//
//  Created by chaos on 2011-03-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CPLinkedListEnumerator.h"


@implementation CPLinkedListEnumerator

+(NSEnumerator *)enumeratorWithSentinel:(CPLinkedNode *)sentinelNode {
	return [[[CPLinkedListEnumerator alloc] initWithSentinel:sentinelNode] autorelease];
}

-(id)initWithSentinel:(CPLinkedNode *)sentinelNode {
	if (self = [super init]) {
		sentinel = sentinelNode;
		currentNode = sentinelNode;
	}
	return self;
}

-(id)nextObject {
	if (currentNode.next != sentinel) {
		currentNode = currentNode.next;
		return currentNode.element;
	}
	return nil;
		
}


@end
