//
//  CPMap.h - Map protocol
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-02-21.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPCollection.h"

@protocol CPMap <CPCollection>

// NSDictionary
-(NSUInteger)count;
-(id)objectForKey:(id)aKey;
-(NSEnumerator *)keyEnumerator;

// NSMutableDictionary
-(id)initWithCapacity:(NSUInteger)numItems;
-(void)setObject:(id)anObject forKey:(id)aKey;
-(void)removeObjectForKey:(id)aKey;
-(void)removeAllObjects;
-(void)removeObjectsForKeys:(NSArray *)keyArray;

-(NSArray *)keys;
-(NSArray *)values;
-(NSEnumerator *)valueEnumerator;

@end
