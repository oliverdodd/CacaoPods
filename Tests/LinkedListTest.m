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

@interface LinkedListTest : GHTestCase
-(id)val:(int)i;
-(void)checkList:(CPLinkedList *)l size:(int)s;
@end

@implementation LinkedListTest

CPLinkedList *linkedList;
int testSize = 1023;

//------------------------------------------------------------------------------
#pragma mark setUp/tearDown

-(void)setUp {
	linkedList = [[CPLinkedList alloc] init];
}

-(void)tearDown {
	[linkedList release];
}

//------------------------------------------------------------------------------
#pragma mark helpers

-(id)val:(int)i {
	return [NSString stringWithFormat:@"Test%d",i];
}

-(void)checkSize:(CPLinkedList *)l size:(int)s {
	GHAssertEquals(s, [l count], @"%d != %d!", [l count], s);
}

-(void)checkList:(CPLinkedList *)l size:(int)s {
	[self checkSize:l size:s];
	int i = 0;
	for (id e in l) {
		NSString *expected = [self val:i];
		GHAssertEqualObjects(expected, e, @"%@ != %@", e, expected);
		GHTestLog(@"%d:%@", i, e);
		i++;
	}
}

-(void)checkListGet:(CPLinkedList *)l size:(int)s {
	[self checkSize:l size:s];
	int i = 0;
	for (i; i < s; i++) {
		NSString *expected = [self val:i];
		id e = [l get:i];
		GHAssertEqualObjects(expected, e, @"%@ != %@", e, expected);
		GHTestLog(@"%d:%@", i, e);
	}
}

//------------------------------------------------------------------------------
#pragma mark init

-(void)test_init {
	GHAssertNotNil(linkedList, @"LinkedList should not be nil");
	[self checkList:linkedList size:0];
}

//------------------------------------------------------------------------------
#pragma mark add

-(void)test_add {
	[linkedList add:[self val:0]];
	[self checkList:linkedList size:1];
}

-(void)test_add_atIndex_0 {
	[linkedList add:[self val:0] atIndex:0];
	[self checkList:linkedList size:1];
}

-(void)test_add_atIndex_i {
	int i = 0;
	for (i; i < testSize; i++)
		[linkedList add:[self val:i]];
	[self checkList:linkedList size:testSize];
}

-(void)test_add_add_atIndex_0 {
	int i = 1;
	// add
	for (i; i < testSize; i++)
		[linkedList add:[self val:i]];
	// add atIndex 0
	[linkedList add:[self val:0] atIndex:0];
	
	[self checkList:linkedList size:testSize];
}

-(void)test_add_add_atIndex_7s {
	int i, d = 7;
	// add non 7s
	for (i = 0; i < testSize; i++)
		if (i % 7 != 0)
			[linkedList add:[self val:i]];
	// add atIndex 7s
	for (i = 0; i < testSize; i += d)
		[linkedList add:[self val:i] atIndex:i];
	// check
	[self checkList:linkedList size:testSize];
}

//------------------------------------------------------------------------------
#pragma mark get

-(void)test_get {
	// add
	int i = 0;
	for (i; i < testSize; i++)
		[linkedList add:[self val:i]];
	// check list using gets
	[self checkListGet:linkedList size:testSize];
}

//------------------------------------------------------------------------------
#pragma mark indexOf

-(void)test_indexOf {
	// add
	int i = 0;
	for (i; i < testSize; i++)
		[linkedList add:[self val:i]];
	// check list
	for (i = 0; i < testSize; i++) {
		id val = [self val:i];
		GHAssertEquals(i, [linkedList indexOf:val], @"index of %@ != %d", val, i);
	}
}

//------------------------------------------------------------------------------
#pragma mark set

-(void)test_set {
	// add
	id val = @"Test";
	int i = 0;
	for (i; i < testSize; i++)
		[linkedList add:val];
	// check list
	for (i = 0; i < testSize; i++) {
		[linkedList set:[self val:i] atIndex:i];
	}
	// check
	[self checkList:linkedList size:testSize];
	[self checkListGet:linkedList size:testSize];
}


//------------------------------------------------------------------------------
#pragma mark remove

-(void)test_remove_1 {
	// add
	int i = 0;
	int s = 3;
	for (i; i < s; i++)
		[linkedList add:[self val:i]];
	[self checkList:linkedList size:s];
	// remove
	id e = [linkedList remove:1];
	//check
	[self checkSize:linkedList size:s - 1];
	GHAssertEqualObjects([self val:0], [linkedList get:0], @"");
	GHAssertEqualObjects([self val:1], e, @"");	
	GHAssertEqualObjects([self val:2], [linkedList get:1], @"");
}

-(void)test_remove_all {
	// add
	int i = 0;
	for (i; i < testSize; i++)
		[linkedList add:[self val:i]];
	// remove
	for (i = testSize - 1; i >= 0; i--) {
		[linkedList remove:i];
		// test every hundred elements
		if (i % 100 == 0)
			[self checkList:linkedList size:i];
	}
	[self checkSize:linkedList size:0];
}



@end
