//
//  TextureUtilities.hpp
//  Stereopsis
//
//  Created by 张函祎 on 15/12/7.
//  Copyright © 2015年 Sylvanus. All rights reserved.
//

#ifndef TextureUtilities_hpp
#define TextureUtilities_hpp

#include <OpenGLES/ES1/gl.h>
#include <OpenGLES/ES1/glext.h>
#include <OpenGLES/gltypes.h>

extern "C" { bool read_png_image(const char *filename, char **data, int *width, int *height); }

GLuint create_texture(char *data, int width, int height, bool pixel_texture = false, GLenum texture_format = GL_RGBA);
GLuint read_png_texture(const char *name, bool pixel_texture = false);
void draw_image(GLuint texture_id, float x, float y, float width, float height, float texcoord_x1, float texcoord_y1, float texcoord_x2, float texcoord_y2, double opacity=1.0);

#endif /* TextureUtilities_hpp */
