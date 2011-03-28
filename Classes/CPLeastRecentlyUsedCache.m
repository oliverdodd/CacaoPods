//
//  CPLeastRecentlyUsedCache.m
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-18.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPLeastRecentlyUsedCache.h"


@implementation CPLeastRecentlyUsedCache

/*-----------------------------------------------------------------------------\
 |	init
 \----------------------------------------------------------------------------*/
#pragma mark init

-(id)initWithCapacity:(NSUInteger)capacity {
	if (self = [super initWithCapacity:capacity keyOrder:CPAccessOrder]) {
		max = capacity;
	}
	return self;
}

-(void)dealloc {
	[super dealloc];
}

/*-----------------------------------------------------------------------------\
 |	set
 \----------------------------------------------------------------------------*/
#pragma mark set

-(void)setObject:(id)anObject forKey:(id)aKey {
	[super setObject:anObject forKey:aKey];
	while ([self count] > max)
		[self removeFirstObject];
}

@end
