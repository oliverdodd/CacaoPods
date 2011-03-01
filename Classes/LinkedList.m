//
//  LinkedList.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-02-21.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "LinkedList.h"
#import "LinkedNode.h"

@interface CPLinkedList (Private)
-(void)checkIndex:(int)index;
-(CPLinkedNode *)entry:(int)index;
-(CPLinkedNode *)addBefore:(id)e node:(CPLinkedNode *)n;
-(void)removeNode:(CPLinkedNode *)n;
@end


@implementation CPLinkedList

/*-----------------------------------------------------------------------------\
 |	init
 \----------------------------------------------------------------------------*/
#pragma mark init

int size = 0;
CPLinkedNode *sentinel = nil;

-(id)init {
	if (self = [super init]) {
		sentinel = [[CPLinkedNode sentinel] retain];
	}
	return self;
}

- (void) dealloc {
    [self clear];
    [sentinel release];
	[super dealloc];
}

/*-----------------------------------------------------------------------------\
 |	get
 \----------------------------------------------------------------------------*/
#pragma mark get

-(void)checkIndex:(int)index {
	if (index > size || index < 0)
		RaiseRangeException(index);
}

-(id)get:(int)index {
	return [self entry:index].element;
}

-(id)first {
	return [self entry:0].element;
}

-(id)last {
	return [self entry:(size - 1)].element;
}

-(id)poll {
	return [self remove:0];
}

-(id)peek {
	return [self first];
}

-(CPLinkedNode *)entry:(int)index {
	[self checkIndex:index];
	CPLinkedNode *n = sentinel;
	int i;
	if (index < (size >> 1)) {
		for (i = 0; i <= index; i++)
			n = n.next;
	} else {
		for (i = size; i > index; i--)
			n = n.previous;
	}
	return n;
}

/*-----------------------------------------------------------------------------\
 |	add
 \----------------------------------------------------------------------------*/
#pragma mark add

-(CPLinkedNode *)addBefore:(id)e node:(CPLinkedNode *)n {
	CPLinkedNode *new = [[CPLinkedNode alloc] init:e next:n previous:n.previous];
	new.previous.next = new;
	new.next.previous = new;
	size++;
	return new;
}

-(void)add:(id)object {
	[self addBefore:object node:sentinel];
}
	
-(void)add:(id)object atIndex:(int)index {
	[self addBefore:object node:(index == size ? sentinel : [self entry:index])];
}

-(void)push:(id)object {
	[self add:object];
}

-(id)set:(id)object atIndex:(int)index {
	CPLinkedNode *n = [self entry:index];
	id element = n.element;
	n.element = object;
	return element;
}

/*-----------------------------------------------------------------------------\
 |	contains
 \----------------------------------------------------------------------------*/
#pragma mark contains

-(BOOL)contains:(id)object {
	return [self indexOf:object] != -1;
}

-(BOOL)containsAll:(NSArray *)collection {
	for (id o in collection)
		if (![self contains:o])
			return NO;
	return YES;
}

-(int)indexOf:(id)object {
	CPLinkedNode *currentNode = sentinel;
	int i = 0;
	while ((currentNode = currentNode.next) != sentinel) {
		if ([object isEqual:currentNode.element])
			return i;
		i++;
	}
	return -1;
}

/*-----------------------------------------------------------------------------\
 |	remove
 \----------------------------------------------------------------------------*/
#pragma mark remove

-(void)clear {
	CPLinkedNode *n;
	while ((n = sentinel.next) != sentinel) {
		sentinel.next = n.next;
		[n release];
	}
	sentinel.previous = sentinel;
	size = 0;
}

-(void)removeNode:(CPLinkedNode *)n; {
	n.previous.next = n.next;
	n.next.previous = n.previous;
	size--;
}

-(id)remove:(int)index {
	CPLinkedNode *n = [self entry:index];
	id element = n.element;
	[self removeNode:n];
	return element;
}

-(BOOL)removeObject:(id)object {
	return NO;//---------------------------------------------------------------------------------------------->
}

/*-----------------------------------------------------------------------------\
 |	size
 \----------------------------------------------------------------------------*/
#pragma mark size

-(int)count {
	return size;
}

-(BOOL)isEmpty {
	return size == 0;
}

/*-----------------------------------------------------------------------------\
 |	enumeration
 \----------------------------------------------------------------------------*/
#pragma mark enumeration

-(NSEnumerator *)objectEnumerator {
	return nil;//-------------------------------------------------------------------------------------->
}

// http://cocoawithlove.com/2008/05/implementing-countbyenumeratingwithstat.html
-(NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
	CPLinkedNode *currentNode;
	if (state->state == 0) {
		currentNode = sentinel.next;
    } else {
		currentNode = (CPLinkedNode *)state->state;
	}
	
	NSUInteger batchCount = 0;
    while (currentNode != sentinel && batchCount < len) {
        stackbuf[batchCount] = currentNode.element;
        currentNode = currentNode.next;
        batchCount++;
    }
	
    state->state = (unsigned long)currentNode;
    state->itemsPtr = stackbuf;
    state->mutationsPtr = (unsigned long *)self;
	
    return batchCount;
}


@end
