//
//  Vertex.h
//  sample
//
//  Created by drinking on 12/2/15.
//  Copyright © 2015 drinking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vertex : NSObject
@property float x;
@property float y;
@property float z;
-(id) initWithX:(float)X Y:(float)Y Z:(float)Z;
-(id) initWithVertex:(Vertex*) v;
-(void) addNormalX:(float)X Y:(float)Y Z:(float)Z;
-(void) addNormalWithVector:(Vertex*) v;
-(void) toUnit;

@end
