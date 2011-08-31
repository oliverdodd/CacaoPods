//
//  LeastRecentlyUsedCacheTest.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-19.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPBaseTestCase.h"
#import "CPLeastRecentlyUsedCache.h"

@interface LeastRecentlyUsedCacheTest : CPBaseTestCase {
	CPLeastRecentlyUsedCache *cache;
	NSUInteger testSize;
}
@end


@implementation LeastRecentlyUsedCacheTest

//------------------------------------------------------------------------------
#pragma mark setUp/tearDown

-(void)setUp {
	testSize = 1023;
	cache = [[CPLeastRecentlyUsedCache alloc] initWithCapacity:testSize];
}

-(void)tearDown {
	[cache release];
}

//------------------------------------------------------------------------------
#pragma mark helpers

-(void)fillCache:(CPLeastRecentlyUsedCache *)c size:(NSUInteger)s {
	int i = 0;
	for (; i < s; i++) {
		[cache setObject:[self val:i] forKey:[self key:i]];
	}
}

-(void)checkCache:(CPLeastRecentlyUsedCache *)c size:(NSUInteger)s {
	[self checkSize:c size:s];
	int i = 0;
	for (; i < s; i++) {
		id key = [self key:i];
		id expected = [self val:i];
		id e = [c objectForKey:key];
		GHAssertEqualObjects(expected, e, @"%@ != %@", e, expected);
		// GHTestLog(@"%d:{%@:%@}", i, key, e);
	}
}

//------------------------------------------------------------------------------
#pragma mark init

-(void)test_initWithCapacity {
	GHAssertNotNil(cache, @"LeastRecentlyUsedCache should not be nil");
	[self checkSize:cache size:0];
}

//------------------------------------------------------------------------------
#pragma mark get/set

-(void)test_set_get_limit {
	[self fillCache:cache size:testSize];
	[self checkCache:cache size:testSize];
}

-(void)test_set_get_over {
	[self fillCache:cache size:testSize];
	
	int i = (int)testSize + 1;
	
	[cache setObject:[self val:i] forKey:[self key:i]];
	GHAssertNotNil([cache objectForKey:[self key:i]], @"");
	GHAssertNil([cache objectForKey:[self key:0]], @"");
}

//------------------------------------------------------------------------------
#pragma mark remove

-(void)test_remove {
	[self fillCache:cache size:testSize];
	int i;
	for (i = (int)testSize - 1; i >= 0; i--) {
		id key = [self key:i];
		GHAssertNotNil([cache objectForKey:key], @"", nil);
		[cache removeObjectForKey:key];
		GHAssertNil([cache objectForKey:key], @"", nil);
		[self checkSize:cache size:i];
	}
}

-(void)test_removeAllObjects {
	[self fillCache:cache size:testSize];
	[cache removeAllObjects];
	[self checkSize:cache size:0];
}

//------------------------------------------------------------------------------
#pragma mark enumeration

-(void)test_countByEnumeratingWithState {
	[self fillCache:cache size:testSize];
	int i = 0;
	for (id e in cache) {
		GHAssertEqualObjects([self key:i], e, @"", nil);
		// GHTestLog(@"%d:%@", i, e);
		i++;
	}
	GHAssertEquals(testSize, (NSUInteger) i, @"", nil);
}


@end
