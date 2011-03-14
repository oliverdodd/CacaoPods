//
//  CPLinkedDictionary.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-12.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPLinkedDictionary.h"

@interface CPLinkedDictionary (Private)
-(CPLinkedMapNode *)addBefore:(id)k value:(id)value node:(CPLinkedMapNode *)n;
-(void)addNodeBefore:(CPLinkedMapNode *)new node:(CPLinkedMapNode *)n;
-(void)removeNode:(CPLinkedMapNode *)n;
@end


@implementation CPLinkedDictionary
@synthesize keyOrder;

/*-----------------------------------------------------------------------------\
 |	init
 \----------------------------------------------------------------------------*/
#pragma mark init

-(id)initWithCapacity:(NSUInteger)numItems keyOrder:(CPKeyOrder)order {
	if (self = [super init]) {
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

- (void) dealloc {
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
	new.previous.next = new;
	new.next.previous = new;
}

-(CPLinkedMapNode *)addBefore:(id)k value:(id)v node:(CPLinkedMapNode *)n {
	CPLinkedMapNode *new = [[CPLinkedMapNode alloc] init:k value:v next:n previous:n.previous];
	[self addNodeBefore:new node:n];
	return new;
}

-(void)removeNode:(CPLinkedMapNode *)n {
	n.previous.next = n.next;
	n.next.previous = n.previous;
}


/*-----------------------------------------------------------------------------\
 |	NSDictionary
 \----------------------------------------------------------------------------*/
#pragma mark NSDictionary

-(id)objectForKey:(id)aKey {
	CPLinkedMapNode *n = [dictionary objectForKey:aKey];
	if (n != nil && keyOrder == CPAccessOrder) {
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
			n = [self addBefore:aKey value:anObject node:sentinel];
		}
		[dictionary setObject:n forKey:aKey];
	}
}

-(void)removeObjectForKey:(id)aKey {
	[self removeNode:[dictionary objectForKey:aKey]];
	[dictionary removeObjectForKey:aKey];
}

//- (void)removeAllObjects;
//- (void)removeObjectsForKeys:(NSArray *)keyArray;


/*-----------------------------------------------------------------------------\
 |	arrays
 \----------------------------------------------------------------------------*/
#pragma mark arrays

-(NSArray *)keys {
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
	
	CPLinkedMapNode *currentNode = sentinel.next;
	while (currentNode != sentinel) {
		[array addObject:currentNode.key];
		currentNode = currentNode.next;
    }
	return array;
}

-(NSEnumerator *)keyEnumerator {
	return [[self keys] objectEnumerator];
}

-(NSArray *)values {
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
	
	CPLinkedMapNode *currentNode = sentinel.next;
	while (currentNode != sentinel) {
		[array addObject:currentNode.value];
		currentNode = currentNode.next;
    }
	return array;
}

-(NSEnumerator *)valueEnumerator {
	return [[self values] objectEnumerator];
}

@end
