//
//  CPLinkedDictionary.h
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-12.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPMap.h"
#import "CPLinkedMapNode.h"

enum {	                          
	CPInsertionOrder = 1,	// Keys are ordered by order of insertion
	CPAccessOrder = 2		// Keys are ordered by order of last access
};
typedef NSUInteger CPKeyOrder;

@interface CPLinkedDictionary : NSMutableDictionary <CPMap> {
	NSMutableDictionary *dictionary;
	CPLinkedMapNode *sentinel;
	CPKeyOrder keyOrder;
}
@property(readonly) CPKeyOrder keyOrder;

-(id)initWithKeyOrder:(CPKeyOrder)order;
-(id)initWithCapacity:(NSUInteger)numItems keyOrder:(CPKeyOrder)order;

-(void)removeFirstObject;
-(void)removeLastObject;

@end
