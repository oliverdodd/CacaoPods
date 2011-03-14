//
//  LinkedNodeTest.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-02-21.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import <GHUnit/GHUnit.h>
#import "CPLinkedNode.h"

@interface LinkedNodeTest : GHTestCase @end

@implementation LinkedNodeTest

-(void)test_init {
	NSString *value = @"test";
	CPLinkedNode *node = [[CPLinkedNode alloc] init:value next:nil previous:nil];
    GHAssertNotNil(node, @"LinkedNode should not be nil");
	GHAssertEqualObjects(value, node.element, @"LinkedNode should contain %@", value);
    [node release];
}

@end
