//
//  CPLinkedDictionaryEnumerator.h
//  CacaoPods
//
//  Lazy Enumerator for a Linked Dictionary
//
//  Created by Oliver C Dodd on 2011-03-20.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPLinkedMapNode.h"
#import "NSEnumerator+hasNext.h"


@interface CPLinkedDictionaryEnumerator : NSEnumerator {
	CPLinkedMapNode *sentinel;
	CPLinkedMapNode *currentNode;
}

+(NSEnumerator *)enumeratorWithSentinel:(CPLinkedMapNode *)sentinelNode;
-(id)initWithSentinel:(CPLinkedMapNode *)sentinelNode;

@end
