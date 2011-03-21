//
//  CPLeastRecentlyUsedCache.h
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-18.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPCollection.h"
#import "CPLinkedDictionary.h"


@interface CPLeastRecentlyUsedCache : NSObject<CPCollection> {
	NSUInteger max;
	CPLinkedDictionary *linkedDictionary;
}

-(id)initWithCapacity:(NSUInteger)capacity;

-(id)objectForKey:(id)aKey;

-(void)setObject:(id)anObject forKey:(id)aKey;

@end
