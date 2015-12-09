//
//  Face.m
//  sample
//
//  Created by drinking on 12/2/15.
//  Copyright © 2015 drinking. All rights reserved.
//

#import "Face.h"

@implementation Face
@synthesize v1;
@synthesize v2;
@synthesize v3;

-(id)initWithV1:(int)V1 V2:(int)V2 V3:(int)V3
{
    if(self = [super init])
    {
        v1 = V1;
        v2 = V2;
        v3 = V3;
    }
    return self;
}

@end
