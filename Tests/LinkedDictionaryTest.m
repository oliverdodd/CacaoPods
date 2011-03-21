//
//  LinkedDictionaryTest.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-12.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import <GHUnit/GHUnit.h>
#import "CPBaseTestCase.h";
#import "CPLinkedDictionary.h"

@interface LinkedDictionaryTest : CPBaseTestCase {
	CPLinkedDictionary *linkedDictionary;
	NSUInteger testSize;
}
@end


@implementation LinkedDictionaryTest

//------------------------------------------------------------------------------
#pragma mark setUp/tearDown

-(void)setUp {
	testSize = 1023;
}

-(void)tearDown {
	[linkedDictionary release];
}

//------------------------------------------------------------------------------
#pragma mark helpers

-(void)fillDictionary:(NSMutableDictionary *)d size:(NSUInteger)s {
	[self forMutableDictionary:d size:s func:^(NSMutableDictionary *d, int i) {
		[d setObject:[self val:i] forKey:[self key:i]];
	}];
}

-(void)checkDictionary:(NSMutableDictionary *)d size:(NSUInteger)s {
	[self checkDictionarySize:d size:s];
	[self forMutableDictionary:d size:s func:^(NSMutableDictionary *d, int i) {
		id key = [self key:i];
		id expected = [self val:i];
		id e = [d objectForKey:key];
		GHAssertEqualObjects(expected, e, @"%@ != %@", e, expected);
		// GHTestLog(@"%d:{%@:%@}", i, key, e);
	}];
}

-(void)checkKeys:(NSArray *)keys {
	int i = 0;
	for (id key in keys) {
		id expected = [self key:i];
		GHAssertEqualObjects(expected, key, @"%@ != %@", key, expected);
		// GHTestLog(@"%d:%@", i, key);
		i++;
	}
	 
}

-(void)checkKeysReversed:(NSArray *)keys {
	NSUInteger s = [keys count];
	int i = 0;
	for (id key in keys) {
		int j = s - i - 1;
		id expected = [self key:j];
		GHAssertEqualObjects(expected, key, @"%@ != %@", key, expected);
		// GHTestLog(@"%d:%@", i, key);
		i++;
	}
}

//------------------------------------------------------------------------------
#pragma mark init

-(void)test_initWithCapacity_keyOrder_CPInsertionOrder {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPInsertionOrder];
	GHAssertNotNil(linkedDictionary, @"LinkedDictionary should not be nil");
	GHAssertTrue(linkedDictionary.keyOrder == CPInsertionOrder, @"", nil);
	[self checkSize:linkedDictionary size:0];
}

-(void)test_initWithCapacity_keyOrder_CPAccessOrder {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPAccessOrder];
	GHAssertNotNil(linkedDictionary, @"LinkedDictionary should not be nil");
	GHAssertTrue(linkedDictionary.keyOrder == CPAccessOrder, @"", nil);
	[self checkSize:linkedDictionary size:0];
}

-(void)test_initWithCapacity {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize];
	GHAssertNotNil(linkedDictionary, @"LinkedDictionary should not be nil");
	GHAssertTrue(linkedDictionary.keyOrder == CPInsertionOrder, @"", nil);
	[self checkSize:linkedDictionary size:0];
}

-(void)test_initWithKeyOrder_CPInsertionOrder {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithKeyOrder:CPInsertionOrder];
	GHAssertNotNil(linkedDictionary, @"LinkedDictionary should not be nil");
	GHAssertTrue(linkedDictionary.keyOrder == CPInsertionOrder, @"", nil);
	[self checkSize:linkedDictionary size:0];
}

-(void)test_initWithKeyOrder_CPAccessOrder {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithKeyOrder:CPAccessOrder];
	GHAssertNotNil(linkedDictionary, @"LinkedDictionary should not be nil");
	GHAssertTrue(linkedDictionary.keyOrder == CPAccessOrder, @"", nil);
	[self checkSize:linkedDictionary size:0];
}

-(void)test_init {
	linkedDictionary = [[CPLinkedDictionary alloc] init];
	GHAssertNotNil(linkedDictionary, @"LinkedDictionary should not be nil");
	GHAssertTrue(linkedDictionary.keyOrder == CPInsertionOrder, @"", nil);
	[self checkSize:linkedDictionary size:0];
}

//------------------------------------------------------------------------------
#pragma mark get/set

-(void)test_set_get_CPInsertionOrder {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPInsertionOrder];
	[self fillDictionary:linkedDictionary size:testSize];
	[self checkDictionary:linkedDictionary size:testSize];
}

-(void)test_keys_CPInsertionOrder {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPInsertionOrder];
	[self fillDictionary:linkedDictionary size:testSize];
	[self checkKeys:[linkedDictionary keys]];
}

-(void)test_keys_get_CPAccessOrder {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPAccessOrder];
	[self fillDictionary:linkedDictionary size:testSize];
	// vars
	NSArray *keys = [linkedDictionary keys];
	id key;
	NSEnumerator *e;
	// keys in insertion order
	[self checkKeys:keys];
	// access in reverse
	e = [keys reverseObjectEnumerator];
	while (key = [e nextObject]) {
		//GHTestLog(@"getting: %@", key);
		[linkedDictionary objectForKey:key];
	}
	// check reversed
	[self checkKeysReversed:[linkedDictionary keys]];
	// access in original order
	e = [keys objectEnumerator];
	while (key = [e nextObject]) {
		//GHTestLog(@"getting: %@", key);
		[linkedDictionary objectForKey:key];
	}
	[self checkKeys:[linkedDictionary keys]];
}

-(void)test_keys_set_CPAccessOrder {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPAccessOrder];
	[self fillDictionary:linkedDictionary size:testSize];
	// vars
	NSArray *keys = [linkedDictionary keys];
	id key;
	NSEnumerator *e;
	// keys in insertion order
	[self checkKeys:keys];
	// set in reverse
	e = [keys reverseObjectEnumerator];
	while (key = [e nextObject]) {
		[linkedDictionary setObject:@"" forKey:key];
	}
	// check reversed
	[self checkKeysReversed:[linkedDictionary keys]];
	// set in original order
	e = [keys objectEnumerator];
	while (key = [e nextObject]) {
		[linkedDictionary setObject:@"" forKey:key];
	}
	[self checkKeys:[linkedDictionary keys]];
}

-(void)test_keys_get_set_random_CPAccessOrder {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPAccessOrder];
	[self fillDictionary:linkedDictionary size:testSize];
	
	int lastIndex = testSize - 1;
	
	// test last index
	id key = [self key:lastIndex];
	GHAssertEqualObjects(key, [[linkedDictionary keys] objectAtIndex:lastIndex], @"", nil);
	
	// access and test random index
	int i = arc4random() % testSize;
	key = [self key:i];
	[linkedDictionary objectForKey:key];
	GHAssertEqualObjects(key, [[linkedDictionary keys] objectAtIndex:lastIndex], @"", nil);
	
	// set and test random index
	i = arc4random() % testSize;
	key = [self key:i];
	[linkedDictionary setObject:@"" forKey:key];
	GHAssertEqualObjects(key, [[linkedDictionary keys] objectAtIndex:lastIndex], @"", nil);
}

//------------------------------------------------------------------------------
#pragma mark remove

-(void)test_remove {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPInsertionOrder];
	[self fillDictionary:linkedDictionary size:testSize];
	[self forMutableDictionaryReverse:linkedDictionary size:testSize func:^(NSMutableDictionary *d, int i) {
		id key = [self key:i];
		GHAssertNotNil([d objectForKey:key], @"", nil);
		[d removeObjectForKey:key];
		GHAssertNil([d objectForKey:key], @"", nil);
		//GHTestLog(@"%d:%@ removed", i, key);
		[self checkSize:linkedDictionary size:i];
	}];
}

-(void)test_removeAllObjects {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPInsertionOrder];
	[self fillDictionary:linkedDictionary size:testSize];
	[linkedDictionary removeAllObjects];
	[self checkSize:linkedDictionary size:0];
}

-(void)test_removeObjectsForKeys {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPInsertionOrder];
	[self fillDictionary:linkedDictionary size:testSize];
	[linkedDictionary removeObjectsForKeys:[linkedDictionary keys]];
	[self checkSize:linkedDictionary size:0];
}

-(void)test_removeFirstObject {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPInsertionOrder];
	[self fillDictionary:linkedDictionary size:testSize];
	
	id key = [self key:0];
	GHAssertNotNil([linkedDictionary objectForKey:key], @"", nil);
	
	[linkedDictionary removeFirstObject];
	GHAssertNil([linkedDictionary objectForKey:key], @"", nil);
	
	[self checkSize:linkedDictionary size:testSize - 1];
}

-(void)test_removeFirstObject_all {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPInsertionOrder];
	[self fillDictionary:linkedDictionary size:testSize];
	int i = 0;
	for (id key in [linkedDictionary keys]) {
		GHAssertNotNil([linkedDictionary objectForKey:key], @"", nil);
		[linkedDictionary removeFirstObject];
		GHAssertNil([linkedDictionary objectForKey:key], @"", nil);
		[self checkSize:linkedDictionary size:(testSize - ++i)];
	};
}

-(void)test_removeLastObject {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPInsertionOrder];
	[self fillDictionary:linkedDictionary size:testSize];
	
	id key = [self key:testSize - 1];
	GHAssertNotNil([linkedDictionary objectForKey:key], @"", nil);
	
	[linkedDictionary removeLastObject];
	GHAssertNil([linkedDictionary objectForKey:key], @"", nil);
	
	[self checkSize:linkedDictionary size:testSize - 1];
}

-(void)test_removeLastObject_all {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPInsertionOrder];
	[self fillDictionary:linkedDictionary size:testSize];
	NSEnumerator *e = [[linkedDictionary keys] reverseObjectEnumerator];
	int i = 0;
	id key = nil;
	while ((key = [e nextObject]) != nil) {
		GHAssertNotNil([linkedDictionary objectForKey:key], @"", nil);
		[linkedDictionary removeLastObject];
		GHAssertNil([linkedDictionary objectForKey:key], @"", nil);
		[self checkSize:linkedDictionary size:(testSize - ++i)];
	}
}

//------------------------------------------------------------------------------
#pragma mark enumerators

-(void)test_key_enumerator {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPInsertionOrder];
	[self fillDictionary:linkedDictionary size:testSize];
	NSEnumerator *e = [linkedDictionary keyEnumerator];
	int i = 0;
	id key = nil;
	while ((key = [e nextObject]) != nil) {
		GHAssertEqualObjects([self key:i], key, @"", nil);
		// GHTestLog(@"%d:%@", i, key);
		i++;
	}
	GHAssertEquals(testSize, (NSUInteger) i, @"", nil);
}

-(void)test_value_enumerator {
	linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:testSize keyOrder:CPInsertionOrder];
	[self fillDictionary:linkedDictionary size:testSize];
	NSEnumerator *e = [linkedDictionary valueEnumerator];
	int i = 0;
	id val = nil;
	while ((val = [e nextObject]) != nil) {
		GHAssertEqualObjects([self val:i], val, @"", nil);
		// GHTestLog(@"%d:%@", i, val);
		i++;
	}
	GHAssertEquals(testSize, (NSUInteger) i, @"", nil);
}



@end
