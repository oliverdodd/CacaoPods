//
//  LinkedMapNodeTest.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-12.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPBaseTestCase.h"
#import "CPLinkedMapNode.h"

@interface LinkedMapNodeTest : GHTestCase
@end


@implementation LinkedMapNodeTest

-(void)test_init {
	NSString *key = @"key";
	NSString *value = @"value";
	CPLinkedMapNode *node = [[CPLinkedMapNode alloc] init:key value:value next:nil previous:nil];
    GHAssertNotNil(node, @"LinkedMapNode should not be nil");
	GHAssertEqualObjects(key, node.key, @"LinkedMapNode should contain key %@", key);
	GHAssertEqualObjects(value, node.value, @"LinkedMapNode should contain key %@", value);
    [node release];
}

@end
