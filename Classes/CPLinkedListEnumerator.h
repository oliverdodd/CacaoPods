//
//  CPLinkedListEnumerator.h
//  CacaoPods
//
//  Lazy NSEnumerator for a Linked List
//
//  Created by Oliver C Dodd on 2011-03-20.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php

//

#import <Cocoa/Cocoa.h>
#import "CPLinkedNode.h"


@interface CPLinkedListEnumerator : NSEnumerator {
	CPLinkedNode *sentinel;
	CPLinkedNode *currentNode;
}

+(NSEnumerator *)enumeratorWithSentinel:(CPLinkedNode *)sentinelNode;
-(id)initWithSentinel:(CPLinkedNode *)sentinelNode;

@end
