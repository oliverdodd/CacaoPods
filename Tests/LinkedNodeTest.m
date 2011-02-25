//
//  LinkedNodeTest.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-02-21.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import <GHUnit/GHUnit.h>
#import "LinkedNode.h"

@interface LinkedNodeTest : GHTestCase @end

@implementation LinkedNodeTest

-(void)test_init {
	NSString *value = @"test";
	LinkedNode *node = [[LinkedNode alloc] init:value next:nil previous:nil];
    GHAssertNotNil(node, @"LinkedList should not be nil");
	GHAssertEquals(value, node.element, @"LinkedList should contain %@", value);
    [node release];
}

@end
