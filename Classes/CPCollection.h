//
//  CPCollection.h
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-01.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

@protocol CPCollection <NSObject, NSFastEnumeration>

-(BOOL)isEmpty;
-(NSUInteger)count;

@end
