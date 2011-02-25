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

@interface LinkedList (Private)
-(void)checkIndex:(int)index;
-(LinkedNode *)entry:(int)index;
-(LinkedNode *)addBefore:(id)e node:(LinkedNode *)n;
@end


@implementation LinkedList

/*-----------------------------------------------------------------------------\
 |	init
 \----------------------------------------------------------------------------*/
#pragma mark init

int size = 0;
LinkedNode *sentinel = nil;

-(id)init {
	if (self = [super init]) {
		sentinel = [[LinkedNode sentinel] retain];
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

-(LinkedNode *)entry:(int)index {
	[self checkIndex:index];
	LinkedNode *n = sentinel;
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

-(LinkedNode *)addBefore:(id)e node:(LinkedNode *)n {
	LinkedNode *new = [[LinkedNode alloc] init:e next:n previous:n.previous];
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

-(void)clear {
	LinkedNode *n;
	while ((n = sentinel.next) != sentinel) {
		sentinel.next = n.next;
		[n release];
	}
	sentinel.previous = sentinel;
	size = 0;
}

-(BOOL)contains:(id)object {
	return NO;
}

-(BOOL)containsAll:(NSArray *)collection {
	return NO;
}

-(int)count {
	return size;
}

-(BOOL)isEmpty {
	return NO;
}

-(int)indexOf:(id)object {
	return -1;
}

-(NSEnumerator *)objectEnumerator {
	return nil;
}

-(id)remove:(int)index {
	return nil;
}

-(BOOL)removeObject:(id)object {
	return NO;
}

-(id)set:(id)object atIndex:(int)index {
	return nil;
}

// http://cocoawithlove.com/2008/05/implementing-countbyenumeratingwithstat.html
-(NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
	LinkedNode *currentNode;
	if (state->state == 0) {
		currentNode = sentinel.next;
    } else {
		currentNode = (LinkedNode *)state->state;
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
