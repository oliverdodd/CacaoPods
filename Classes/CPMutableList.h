//
//  MutableList.h - Mutable List protocol
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-02-21.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPList.h"

@protocol CPMutableList <CPList>

-(void)add:(id)object;
-(void)add:(id)object atIndex:(int)index;

-(void)clear;

-(id)remove:(int)index;
-(BOOL)removeObject:(id)object;

-(id)set:(id)object atIndex:(int)index;

@end
