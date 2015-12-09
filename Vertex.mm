//
//  Vertex.m
//  sample
//
//  Created by drinking on 12/2/15.
//  Copyright © 2015 drinking. All rights reserved.
//

#import <math.h>
#import "Vertex.h"

@implementation Vertex

@synthesize x;
@synthesize y;
@synthesize z;

-(id) initWithX:(float)X Y:(float)Y Z:(float)Z
{
    if(self = [super init])
    {
        x = X;
        y = Y;
        z = Z;
    }
    return self;
}

-(id) initWithVertex:(Vertex*) v
{
    if(self = [super init])
    {
        if(v == NULL) return NULL;
        x = v.x;
        y = v.y;
        z = v.z;
    }
    return self;
}

-(void) addNormalX:(float)X Y:(float)Y Z:(float)Z
{
    x+=X;
    y+=Y;
    z+=Z;
}

-(void) addNormalWithVector:(Vertex*) v
{
    x+=v.x;
    y+=v.y;
    z+=v.z;
}

-(void) toUnit
{
    float l = sqrt(x*x+y*y+z*z);
    x/=l;
    y/=l;
    z/=l;
}

@end
