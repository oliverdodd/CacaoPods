//
//  CPLinkedDictionaryValueEnumerator.h
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-20.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPLinkedDictionaryEnumerator.h"


@interface CPLinkedDictionaryValueEnumerator : CPLinkedDictionaryEnumerator

+(NSEnumerator *)enumeratorWithSentinel:(CPLinkedMapNode *)sentinelNode;

@end
