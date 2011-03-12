//
//  Deque.h - Double-Ended Queue protocol
//  CacaoPods
//
//  Created by Oliver C Dodd on 2011-03-01.
//  Copyright 2010 Oliver C Dodd http://01001111.net
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#import "CPQueue.h"

@protocol CPDeque <CPQueue>

-(void)unshift:(id)object;
-(id)shift;
-(id)pop;

-(id)first;
-(id)last;

@end
