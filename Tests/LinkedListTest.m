//
//  LinkedListTest.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-02-21.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import <GHUnit/GHUnit.h>
#import "LinkedList.h"

@interface LinkedListTest : GHTestCase @end

@implementation LinkedListTest

LinkedList *linkedList;

-(void)setUp {
	linkedList = [[LinkedList alloc] init];
}

-(void)tearDown {
	[linkedList release];
}

-(void)test_init {
	GHAssertNotNil(linkedList, @"LinkedList should not be nil");
	GHAssertEquals(0, [linkedList count], @"%d != 0", [linkedList count]);
}

-(void)test_add {
	[linkedList add:@"Test"];
	GHAssertEquals(1, [linkedList count], @"%d != 1!", [linkedList count]);
}

-(void)test_add_atIndex_0 {
	[linkedList add:@"Test" atIndex:0];
	GHAssertEquals(1, [linkedList count], @"%d != 1!", [linkedList count]);
}

-(void)test_add_atIndex_0_multiple {
	int s = 10;
	int i = 1;
	// add
	for (i; i < s; i++)
		[linkedList add:[NSString stringWithFormat:@"Test%d",i]];
	// add atIndex
	i = 0;
	[linkedList add:[NSString stringWithFormat:@"Test%d",i] atIndex:i];
	
	GHAssertEquals(s, [linkedList count], @"%d != %d!", [linkedList count], s);
	for (id e in linkedList) {
		NSString *expected = [NSString stringWithFormat:@"Test%d",i];
		GHAssertEqualObjects(expected, e, @"%@ != %@", e, expected);
		i++;
	}
}



@end
