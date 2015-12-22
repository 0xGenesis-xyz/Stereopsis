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

-(double) length
{
    return sqrt(x*x+y*y+z*z);
}
+(double) multiply:(Vertex *)v1 dot:(Vertex *)v2
{
    return (v1.x*v2.x+v1.y*v2.y+v1.z*v2.z);
}

+(Vertex*) multiply:(Vertex *)v1 cross:(Vertex *)v2
{
    Vertex* res = [[Vertex alloc]initWithX:v1.y*v2.z-v1.z*v2.y Y:v1.z*v2.x-v1.x*v2.z Z:v1.x*v2.y-v1.y*v2.x];
    return res;
}

@end
