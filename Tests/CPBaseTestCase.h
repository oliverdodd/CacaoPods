//
//  CPBaseTestCase.h
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-13.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import <Cocoa/Cocoa.h>
#import <GHUnit/GHUnit.h>
#import "CPCollection.h"
#import "CPLinkedList.h"

@interface CPBaseTestCase : GHTestCase

// TODO: Remove these.  Instead extend classes with each function

-(void)forLinkedList:(CPLinkedList *)l size:(NSUInteger)s func:(void (^)(CPLinkedList*,int))func;
-(void)forLinkedListReverse:(CPLinkedList *)l size:(NSUInteger)s func:(void (^)(CPLinkedList*,int))func;
-(void)forArray:(NSArray *)a size:(NSUInteger)s func:(void (^)(NSArray*,int))func;
-(void)forMutableArray:(NSMutableArray *)a size:(NSUInteger)s func:(void (^)(NSMutableArray*,int))func;
-(void)forMutableDictionary:(NSMutableDictionary *)d size:(NSUInteger)s func:(void (^)(NSMutableDictionary*,int))func;
-(void)forMutableDictionaryReverse:(NSMutableDictionary *)d size:(NSUInteger)s func:(void (^)(NSMutableDictionary*,int))func;

-(void)checkSize:(id<CPCollection>)l size:(NSUInteger)s;
-(void)checkDictionarySize:(NSDictionary *)d size:(NSUInteger)s;

-(id)key:(int)i;
-(id)val:(int)i;

@end
