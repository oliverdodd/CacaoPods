//
//  LinkedNode.h
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-02-21.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

@interface CPLinkedNode : NSObject {
	id element;
	CPLinkedNode *next;
	CPLinkedNode *previous;
}
@property(copy) id element;
@property(retain) CPLinkedNode *next;
@property(retain) CPLinkedNode *previous;

-(id)init:(id)e next:(id)n previous:(id)p;

+(CPLinkedNode *)sentinel;

@end
