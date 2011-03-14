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

-(id)key:(int)i {
	return [NSString stringWithFormat:@"Key%d",i];
}

-(id)val:(int)i {
	return [NSString stringWithFormat:@"Value%d",i];
}

-(void)fillDictionary:(NSMutableDictionary *)d size:(NSUInteger)s {
	[self forMutableDictionary:d size:s func:^(NSMutableDictionary *d, int i) {
		[d setObject:[self val:i] forKey:[self key:i]];
	}];
}

-(void)checkDictionary:(NSMutableDictionary *)d size:(NSUInteger)s {
	[self checkDictionarySize:d size:s];
	[self forMutableDictionary:d size:s func:^(NSMutableDictionary *d, int i) {
		NSString *key = [self key:i];
		NSString *expected = [self val:i];
		id e = [d objectForKey:key];
		GHAssertEqualObjects(expected, e, @"%@ != %@", e, expected);
		GHTestLog(@"%d:{%@:%@}", i, key, e);
	}];
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

//-(void)setObject:(id)anObject forKey:(id)aKey



@end
