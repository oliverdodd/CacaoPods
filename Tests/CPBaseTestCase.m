//
//  CPBaseTestCase.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-13.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPBaseTestCase.h"

@implementation CPBaseTestCase

/*-----------------------------------------------------------------------------\
 |	collection iteration
 \----------------------------------------------------------------------------*/
#pragma mark collection iteration

-(void)forLinkedList:(CPLinkedList *)l size:(NSUInteger)s func:(void (^)(CPLinkedList*,int))func {
	int i = 0;
	for (i; i < s; i++)
		func(l,i);
}

-(void)forLinkedListReverse:(CPLinkedList *)l size:(NSUInteger)s func:(void (^)(CPLinkedList*,int))func {
	int i = s - 1;
	for (i; i >= 0; i--)
		func(l,i);
}

-(void)forArray:(NSArray *)a size:(NSUInteger)s func:(void (^)(NSArray*,int))func {
	int i = 0;
	for (i; i < s; i++)
		func(a,i);
}

-(void)forMutableArray:(NSMutableArray *)a size:(NSUInteger)s func:(void (^)(NSMutableArray*,int))func {
	int i = 0;
	for (i; i < s; i++)
		func(a,i);
}

-(void)forMutableDictionary:(NSMutableDictionary *)d size:(NSUInteger)s func:(void (^)(NSMutableDictionary*,int))func {
	int i = 0;
	for (i; i < s; i++)
		func(d,i);
}

-(void)forMutableDictionaryReverse:(NSMutableDictionary *)d size:(NSUInteger)s func:(void (^)(NSMutableDictionary*,int))func {
	int i = s - 1;
	for (i; i >= 0; i--)
		func(d,i);
}

/*-----------------------------------------------------------------------------\
 |	collection checking
 \----------------------------------------------------------------------------*/
#pragma mark collection checking

-(void)checkSize:(id<CPCollection>)l size:(NSUInteger)s {
	GHAssertEquals(s, [l count], @"collection size %d != %d!", [l count], s);
}

-(void)checkDictionarySize:(NSDictionary *)d size:(NSUInteger)s {
	GHAssertEquals(s, [d count], @"dictionary size %d != %d!", [d count], s);
}

/*-----------------------------------------------------------------------------\
 |	test values
 \----------------------------------------------------------------------------*/
#pragma mark test values

-(id)key:(int)i {
	return [NSString stringWithFormat:@"Key%d",i];
}

-(id)val:(int)i {
	return [NSString stringWithFormat:@"Value%d",i];
}

@end
