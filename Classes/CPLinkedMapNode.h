//
//  CPLinkedMapNode.h
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-12.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import <Cocoa/Cocoa.h>

@interface CPLinkedMapNode : NSObject {
	id key;
	id value;
	CPLinkedMapNode *next;
	CPLinkedMapNode *previous;
}
@property(copy) id key;
@property(copy) id value;
@property(retain) CPLinkedMapNode *next;
@property(retain) CPLinkedMapNode *previous;

-(id)init:(id)aKey value:(id)aValue next:(id)n previous:(id)p;

+(CPLinkedMapNode *)sentinel;

@end
