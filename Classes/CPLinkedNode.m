//
//  CPLinkedNode.m - Linked List Node
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-02-21.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPLinkedNode.h"

@implementation CPLinkedNode
@synthesize element, next, previous;

+(CPLinkedNode *)sentinel {
	CPLinkedNode *sentinel = [[CPLinkedNode alloc] init:nil next:nil previous:nil];
	sentinel.next = sentinel;
	sentinel.previous = sentinel;
	return sentinel;
}

-(id)init:(id)e next:(id)n previous:(id)p {
	if ((self = [super init])) {
		self.element = e;
		self.next = n;
		self.previous = p;
	}
	return self;
}

-(void)dealloc {
	[element release];
	[super dealloc];
}

@end
