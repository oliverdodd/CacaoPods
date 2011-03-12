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
-(void)fillList:(CPLinkedList *)l size:(int)s;
-(void)checkSize:(CPLinkedList *)l size:(int)s;
-(void)checkList:(CPLinkedList *)l size:(int)s;
-(void)checkListGet:(CPLinkedList *)l size:(int)s;
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

-(void)forList:(CPLinkedList *)l size:(int)s func:(void (^)(CPLinkedList*,int))func {
	int i = 0;
	for (i; i < s; i++)
		func(l,i);
}

-(void)forListReverse:(CPLinkedList *)l size:(int)s func:(void (^)(CPLinkedList*,int))func {
	int i = s - 1;
	for (i; i >= 0; i--)
		func(l,i);
}

-(void)fillList:(CPLinkedList *)l size:(int)s {
	[self forList:l size:s func:^(CPLinkedList *l, int i) { [l add:[self val:i]]; }];
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
	[self forList:l size:s func:^(CPLinkedList *l, int i) {
		NSString *expected = [self val:i];
		id e = [l get:i];
		GHAssertEqualObjects(expected, e, @"%@ != %@", e, expected);
		GHTestLog(@"%d:%@", i, e);
	}];
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
		[linkedList add:[self val:i] atIndex:i];
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
	[self fillList:linkedList size:testSize];
	[self checkListGet:linkedList size:testSize];
}

-(void)test_first {
	[self fillList:linkedList size:testSize];
	GHAssertEqualObjects([self val:0], [linkedList first], @"", nil);
}

-(void)test_last {
	[self fillList:linkedList size:testSize];
	GHAssertEqualObjects([self val:(testSize - 1)], [linkedList last], @"", nil);
}

//------------------------------------------------------------------------------
#pragma mark indexOf

-(void)test_indexOf {
	// add
	[self fillList:linkedList size:testSize];
	// check list
	int i = 0;
	for (i; i < testSize; i++) {
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
	// set
	for (i = 0; i < testSize; i++) {
		[linkedList set:[self val:i] atIndex:i];
	}
	// check
	[self checkList:linkedList size:testSize];
	[self checkListGet:linkedList size:testSize];
}

//------------------------------------------------------------------------------
#pragma mark contains

-(void)test_contains {
	// add
	[self fillList:linkedList size:testSize];
	// check
	[self forList:linkedList size:testSize func:^(CPLinkedList *l, int i) {
		GHAssertTrue([l contains:[self val:i]], @"", nil);
	}];
}

-(void)test_containsAll {
	// add
	[self fillList:linkedList size:testSize];
	// check
	NSMutableArray *a = [NSMutableArray arrayWithCapacity:testSize];
	int i = 0;
	for (i; i < testSize; i++) {
		[a addObject:[self val:i]];
	}
	GHAssertTrue([linkedList containsAll:a], @"", nil);
}

//------------------------------------------------------------------------------
#pragma mark remove

-(void)test_remove_1 {
	// add
	int s = 3;
	[self fillList:linkedList size:s];
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
	[self fillList:linkedList size:testSize];
	// remove
	[self forListReverse:linkedList size:testSize func:^(CPLinkedList *l, int i) {
		GHAssertFalse([linkedList contains:[linkedList remove:i]], @"", nil);
		// test every hundred elements
		if (i % 100 == 0)
			[self checkList:linkedList size:i];
	}];
	[self checkSize:linkedList size:0];
}

-(void)test_removeObject {
	// add
	[self fillList:linkedList size:testSize];
	// remove
	id valid = [self val:(testSize / 2)];
	id invalid = [self val:(testSize / 2)];
	
	GHAssertTrue([linkedList contains:valid], @"", nil);
	GHAssertTrue([linkedList removeObject:valid], @"", nil);
	GHAssertFalse([linkedList contains:valid], @"", nil);
	
	GHAssertFalse([linkedList removeObject:invalid], @"", nil);
}

//------------------------------------------------------------------------------
#pragma mark Queue

-(void)test_peek {
	[self fillList:linkedList size:testSize];
	GHAssertEqualObjects([self val:0], [linkedList peek], @"", nil);
}

-(void)test_poll {
	// add
	[self fillList:linkedList size:testSize];
	// pop
	[self forList:linkedList size:testSize func:^(CPLinkedList *l, int i) {
		GHAssertEqualObjects([self val:i], [l poll], @"", nil);
		[self checkSize:l size:(testSize - i - 1)];
	}];
}

-(void)test_push {
	// fill
	[self forList:linkedList size:testSize func:^(CPLinkedList *l, int i) {
		[l push:[self val:i]];
	}];
	// check
	[self checkList:linkedList size:testSize];
}

//------------------------------------------------------------------------------
#pragma mark Deque

-(void)test_unshift {
	// fill
	[self forListReverse:linkedList size:testSize func:^(CPLinkedList *l, int i) {
		[l unshift:[self val:i]];
	}];
	// check
	[self checkList:linkedList size:testSize];
}

-(void)test_shift {
	// add
	[self fillList:linkedList size:testSize];
	// pop
	[self forList:linkedList size:testSize func:^(CPLinkedList *l, int i) {
		GHAssertEqualObjects([self val:i], [l shift], @"", nil);
		[self checkSize:l size:(testSize - i - 1)];
	}];
}

-(void)test_pop {
	// add
	[self fillList:linkedList size:testSize];
	// pop
	[self forListReverse:linkedList size:testSize func:^(CPLinkedList *l, int i) {
		GHAssertEqualObjects([self val:i], [l pop], @"", nil);
		[self checkSize:l size:i];
	}];
}

@end
