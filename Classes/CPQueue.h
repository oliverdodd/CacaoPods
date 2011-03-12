//
//  CPQueue.h - Queue protocol
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-02-21.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPCollection.h"

@protocol CPQueue<CPCollection>

-(id)poll;
-(id)peek;
-(void)push:(id)object;

// enqueue one or many objects
// dequeue 

@end
