//
//  List.h
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-02-21.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import <Cocoa/Cocoa.h>


@protocol CPList <NSFastEnumeration>

-(BOOL)contains:(id)object;
-(BOOL)containsAll:(NSArray *)collection;
-(BOOL)isEmpty;

-(int)count;
-(int)indexOf:(id)object;

-(id)get:(int)index;

-(NSEnumerator *)objectEnumerator;

@end
