//
//  CPLinkedList.h - Linked List
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-02-21.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPList.h"
#import "CPMutableList.h"
#import "CPQueue.h"
#import "CPDeque.h"

@interface CPLinkedList : NSObject<CPMutableList, CPQueue, CPDeque>

-(NSArray *)array;

@end
