//
//  OBJ.h
//  sample
//
//  Created by drinking on 12/2/15.
//  Copyright © 2015 drinking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import <GLKit/GLKit.h>
#import "Vertex.h"
#import "Face.h"
#include <OpenGLES/ES1/gl.h>
#include <OpenGLES/ES1/glext.h>
#include <OpenGLES/gltypes.h>
#import "Texture.h"
#import <math.h>

@interface OBJ : NSObject

@property GLuint vertexArray;

-(void) loadObj:(NSString*) filename Texture:(NSString*) textfilename;
-(void) setUp;
-(void) drawObj;

@end