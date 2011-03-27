//
//  CPLeastRecentlyUsedCache.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-18.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPLeastRecentlyUsedCache.h"
#import "NSEnumerator+hasNext.h"


@implementation CPLeastRecentlyUsedCache

/*-----------------------------------------------------------------------------\
 |	init
 \----------------------------------------------------------------------------*/
#pragma mark init

-(id)initWithCapacity:(NSUInteger)capacity {
	if (self = [super init]) {
		max = capacity;
		linkedDictionary = [[CPLinkedDictionary alloc] initWithCapacity:capacity 
															   keyOrder:CPAccessOrder];
	}
	return self;
}

-(void)dealloc {
	[linkedDictionary release];
	[super dealloc];
}

/*-----------------------------------------------------------------------------\
 |	CPCollection
 \----------------------------------------------------------------------------*/
#pragma mark CPCollection

-(BOOL)isEmpty {
	return [self count] == 0;
}

-(NSUInteger)count {
	return [linkedDictionary count];
}

/*-----------------------------------------------------------------------------\
 |	get / set
 \----------------------------------------------------------------------------*/
#pragma mark get/set

-(id)objectForKey:(id)aKey {
	return [linkedDictionary objectForKey:aKey];
}

-(void)setObject:(id)anObject forKey:(id)aKey {
	[linkedDictionary setObject:anObject forKey:aKey];
	while ([linkedDictionary count] > max)
		[linkedDictionary removeFirstObject];
}

/*-----------------------------------------------------------------------------\
 |	remove
 \----------------------------------------------------------------------------*/
#pragma mark remove

-(void)removeObjectForKey:(id)aKey {
	[linkedDictionary removeObjectForKey:aKey];
}

-(void)removeAllObjects {
	[linkedDictionary removeAllObjects];
}

-(void)removeObjectsForKeys:(NSArray *)keyArray {
	[linkedDictionary removeObjectsForKeys:keyArray];
}

/*-----------------------------------------------------------------------------\
 |	enumeration
 \----------------------------------------------------------------------------*/
#pragma mark enumeration

-(NSArray *)keys {
	return [linkedDictionary keys];
}

-(NSEnumerator *)keyEnumerator {
	return [linkedDictionary keyEnumerator];
}

-(NSArray *)values {
	return [linkedDictionary values];	
}

-(NSEnumerator *)valueEnumerator {
	return [linkedDictionary valueEnumerator];
}

-(NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
	NSEnumerator *enumerator;
	if (state->state == 0) {
		enumerator = [linkedDictionary valueEnumerator];
	} else {
		enumerator = (NSEnumerator *)state->state;
	}
	
	NSUInteger batchCount = 0;
	while ([enumerator hasNext] && batchCount < len) {
		stackbuf[batchCount] = [enumerator nextObject];
		batchCount++;
	}
	
	state->state = (unsigned long)enumerator;
	state->itemsPtr = stackbuf;
	state->mutationsPtr = (unsigned long *)self;
	
	return batchCount;
}

@end
