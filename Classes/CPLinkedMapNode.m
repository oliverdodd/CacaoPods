//
//  CPLinkedMapNode.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-12.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPLinkedMapNode.h"


@implementation CPLinkedMapNode
@synthesize key, value, next, previous;

+(CPLinkedMapNode *)sentinel {
	CPLinkedMapNode *sentinel = [[CPLinkedMapNode alloc] init:nil value:nil next:nil previous:nil];
	sentinel.next = sentinel;
	sentinel.previous = sentinel;
	return sentinel;
}

-(id)init:(id)aKey value:(id)aValue next:(id)n previous:(id)p {
	if (self = [super init]) {
		self.key = aKey;
		self.value = aValue;
		self.next = n;
		self.previous = p;
	}
	return self;
}

-(void)dealloc {
	[key release];
	[value release];
	[super dealloc];
}

@end
