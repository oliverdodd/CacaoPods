//
//  CPLinkedDictionary.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-12.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPLinkedDictionary.h"
#import "CPLinkedDictionaryKeyEnumerator.h"
#import "CPLinkedDictionaryValueEnumerator.h"


@interface CPLinkedDictionary (Private)
-(CPLinkedMapNode *)addBefore:(id)k value:(id)value node:(CPLinkedMapNode *)n;
-(void)addNodeBefore:(CPLinkedMapNode *)new node:(CPLinkedMapNode *)n;
-(void)removeNode:(CPLinkedMapNode *)n;
-(void)removeObjectAtNode:(CPLinkedMapNode *)n;
-(NSArray *)arrayFromEnumerator:(NSEnumerator *)e;
@end


@implementation CPLinkedDictionary
@synthesize keyOrder;

/*-----------------------------------------------------------------------------\
 |	init
 \----------------------------------------------------------------------------*/
#pragma mark init

-(id)initWithCapacity:(NSUInteger)numItems keyOrder:(CPKeyOrder)order {
	if ((self = [super init])) {
		dictionary = [[NSMutableDictionary alloc] initWithCapacity:numItems];
		sentinel = [CPLinkedMapNode sentinel];
		keyOrder = order;
	}
	return self;
}

-(id)initWithCapacity:(NSUInteger)numItems {
	return [self initWithCapacity:numItems keyOrder:CPInsertionOrder];
}

-(id)initWithKeyOrder:(CPKeyOrder)order {
	return [self initWithCapacity:0 keyOrder:order];
}

-(id)init {
	return [self initWithCapacity:0 keyOrder:CPInsertionOrder];
}

-(void)dealloc {
	[self removeAllObjects];
	[dictionary release];
    [sentinel release];
	[super dealloc];
}

/*-----------------------------------------------------------------------------\
 |	size
 \----------------------------------------------------------------------------*/
#pragma mark size

-(NSUInteger)count {
	return [dictionary count];
}

-(BOOL)isEmpty {
	return [self count] == 0;
}

/*-----------------------------------------------------------------------------\
 |	node operations
 \----------------------------------------------------------------------------*/
#pragma mark node operations

-(void)addNodeBefore:(CPLinkedMapNode *)new node:(CPLinkedMapNode *)n {
	new.next = n;
	new.previous = n.previous;
	new.previous.next = new;
	new.next.previous = new;
}

-(CPLinkedMapNode *)addBefore:(id)k value:(id)v node:(CPLinkedMapNode *)n {
	CPLinkedMapNode *new = [[CPLinkedMapNode alloc] init:k value:v next:n previous:n.previous];
	new.previous.next = new;
	new.next.previous = new;
	return new;
}

-(void)removeNode:(CPLinkedMapNode *)n {
	n.previous.next = n.next;
	n.next.previous = n.previous;
}

-(void)removeObjectAtNode:(CPLinkedMapNode *)n {
	[self removeNode:n];
	[dictionary removeObjectForKey:n.key];
	[n release];
}

/*-----------------------------------------------------------------------------\
 |	NSDictionary
 \----------------------------------------------------------------------------*/
#pragma mark NSDictionary

-(id)objectForKey:(id)aKey {
	CPLinkedMapNode *n = [dictionary objectForKey:aKey];
	if (n != nil && keyOrder == CPAccessOrder) {
		[self removeNode:n];
		[self addNodeBefore:n node:sentinel];
	}
	return n.value;
}


/*-----------------------------------------------------------------------------\
 |	NSMutableDictionary
 \----------------------------------------------------------------------------*/
#pragma mark NSMutableDictionary

-(void)setObject:(id)anObject forKey:(id)aKey {
	CPLinkedMapNode *n = [dictionary objectForKey:aKey];
	if (n == nil) {
		n = [self addBefore:aKey value:anObject node:sentinel];
		[dictionary setObject:n forKey:aKey];
	} else {
		n.value = anObject;
		if (keyOrder == CPAccessOrder) {
			[self removeNode:n];
			n.value = anObject;
			[self addNodeBefore:n node:sentinel];
		}
		[dictionary setObject:n forKey:aKey];
	}
}

-(void)removeObjectForKey:(id)aKey {
	CPLinkedMapNode *n = [dictionary objectForKey:aKey];
	[self removeNode:n];
	[dictionary removeObjectForKey:aKey];
	[n release];
}

-(void)removeFirstObject {
	if ([self count] > 0)
		[self removeObjectAtNode:sentinel.next];
}

-(void)removeLastObject {
	if ([self count] > 0)
		[self removeObjectAtNode:sentinel.previous];
}

-(void)removeAllObjects {
	[dictionary removeAllObjects];
	
	CPLinkedMapNode *n;
	while ((n = sentinel.next) != sentinel) {
		sentinel.next = n.next;
		[n release];
	}
	sentinel.previous = sentinel;
	
}

-(void)removeObjectsForKeys:(NSArray *)keyArray {
	for (id key in keyArray)
		[self removeObjectForKey:key];
}


/*-----------------------------------------------------------------------------\
 |	arrays / enumerators
 \----------------------------------------------------------------------------*/
#pragma mark arrays / enumerators

-(NSArray *)arrayFromEnumerator:(NSEnumerator *)e {
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
	id v = nil;
	while ((v = [e nextObject]) != nil)
		[array addObject:v];
	return array;
}

-(NSEnumerator *)keyEnumerator {
	return [CPLinkedDictionaryKeyEnumerator enumeratorWithSentinel:sentinel];
}

-(NSArray *)keys {
	return [self arrayFromEnumerator:[self keyEnumerator]];
}

-(NSArray *)keysSortedByValueUsingSelector:(SEL)comparator {
	return [[self keys] sortedArrayUsingSelector:comparator];
}

-(NSEnumerator *)valueEnumerator {
	return [CPLinkedDictionaryValueEnumerator enumeratorWithSentinel:sentinel];
}

-(NSArray *)values {
	return [self arrayFromEnumerator:[self valueEnumerator]];;
}

@end
