//
//  Texture.h
//  sample
//
//  Created by drinking on 12/2/15.
//  Copyright © 2015 drinking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <OpenGLES/ES1/gl.h>
#include <OpenGLES/ES1/glext.h>
#include <OpenGLES/gltypes.h>

@interface Texture : NSObject

@property GLuint textureID;

@property GLubyte* texturedata;
@property CGImageRef textureImage;
@property NSInteger texWidth;
@property NSInteger texHeight;

-(int) LoadTextureFileName:(NSString*)filename TextureID:(GLuint) textureID;
-(void) UseTexture;

@end
