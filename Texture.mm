//
//  Texture.m
//  sample
//
//  Created by drinking on 12/2/15.
//  Copyright © 2015 drinking. All rights reserved.
//

#import "Texture.h"

@implementation Texture

@synthesize textureImage;
@synthesize texturedata;
@synthesize texWidth;
@synthesize texHeight;

CGContextRef CreateRGBABitmapContext (CGImageRef inImage)
{
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    void *bitmapData;
    int bitmapByteCount;
    int bitmapBytesPerRow;
    
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    bitmapBytesPerRow = (pixelsWide * 4);
    bitmapByteCount = (bitmapBytesPerRow * pixelsHigh);
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL){
        fprintf(stderr, "Error allocating color space");
        return NULL;
    }
    
    // allocate the bitmap & create context
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL){
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    context = CGBitmapContextCreate (bitmapData, pixelsWide,pixelsHigh, 8, bitmapBytesPerRow,
                                     colorSpace, kCGImageAlphaPremultipliedLast);
    if (context == NULL){
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    CGColorSpaceRelease( colorSpace );
    return context;
}

-(int) LoadTextureFileName:(NSString*)filename TextureID:(GLuint) textureID
{
    /*
    UIImage* img = [UIImage imageNamed:filename];
    CGImageRef imageRef = [img CGImage];
    _size = [img size];
    CGContextRef cgctx = CreateRGBABitmapContext(imageRef);
    if (cgctx == NULL)
        return NULL;
    CGRect rect = {{0,0},{_size.width, _size.height}};
    NSLog(@"size width = %f;height = %f",_size.width,_size.height);
    CGContextDrawImage(cgctx, rect, imageRef);
    _data = CGBitmapContextGetData (cgctx);
    CGContextRelease(cgctx);
    _textureID = textureID;
     */
    textureImage = [UIImage imageNamed:filename].CGImage;
    _textureID = textureID;
    if (textureImage == nil) {
        NSLog(@"Failed to load texture image");
        return 0;
    }
    texWidth = CGImageGetWidth(textureImage);
    texHeight = CGImageGetHeight(textureImage);
    texturedata = (GLubyte *)malloc(texWidth * texHeight * 4);
        
    CGContextRef textureContext = CGBitmapContextCreate(
                                                        texturedata,
                                                        texWidth,
                                                        texHeight,
                                                        8, texWidth * 4,
                                                        CGImageGetColorSpace(textureImage),
                                                        kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(textureContext,
                       CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight),
                       textureImage);
    
    CGContextRelease(textureContext);
    
    return 1;
}

-(void) UseTexture
{
   // glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _textureID);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

    glTexImage2D(GL_TEXTURE_2D,
                 0, 	    //mipmap层次(通常为，表示最上层)
                 GL_RGBA,	//我们希望该纹理有红、绿、蓝数据
                 texWidth, //纹理宽带，必须是n，若有边框+2
                 texHeight, //纹理高度，必须是n，若有边框+2
                 0, //边框(0=无边框, 1=有边框)
                 GL_RGBA,	//bitmap数据的格式
                 GL_UNSIGNED_BYTE, //每个颜色数据的类型
                 texturedata);	//bitmap数据指针
}


@end
