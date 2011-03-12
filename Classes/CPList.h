//
//  CPList.h - List protocol
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-02-21.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPCollection.h"

@protocol CPList <CPCollection>

-(BOOL)contains:(id)object;
-(BOOL)containsAll:(NSArray *)collection;

-(int)indexOf:(id)object;

-(id)get:(int)index;
-(id)first;
-(id)last;

-(NSEnumerator *)objectEnumerator;

@end
