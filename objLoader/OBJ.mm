//
//  OBJ.m
//  sample
//
//  Created by drinking on 12/2/15.
//  Copyright © 2015 drinking. All rights reserved.
//

#import "OBJ.h"
#import <OpenGLES/ES2/glext.h>

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

float sqr(float k)
{
    return k*k;
}

@interface OBJ()
{
    Texture* texture;
    GLfloat* buffer;
    long vertex_off,normal_off,text_off;
    long buffer_size;
    long buffer_stride;
    GLuint vertexBuffer;
    GLuint vertexNum;
}
@end

@implementation OBJ

@synthesize vertexArray;
@synthesize size;
@synthesize velocity;
@synthesize position;
@synthesize direction;

-(id)init
{
    if(self = [super init])
    {
        buffer = NULL;
    }
    return (self);
}

-(void)dealloc
{
    free(buffer);
}

-(void) loadObj:(NSString*)filename Texture:(NSString *)textfilename
{
    NSMutableArray* textVertices = [[NSMutableArray alloc] init];
    NSMutableArray* vertices = [[NSMutableArray alloc] init];
    NSMutableArray* normals = [[NSMutableArray alloc] init];
    NSMutableArray* textFaces = [[NSMutableArray alloc] init];
    NSMutableArray* faces = [[NSMutableArray alloc] init];
    NSMutableArray* normalFaces = [[NSMutableArray alloc] init];
    Vertex *v;
    Face *f;
    FILE* fp;
    int v1,v2,v3,tv1,tv2,tv3,n1,n2,n3;
    float x,y,z;
    float a1,a2,a3,b1,b2,b3,la,lb;
    Vertex *maxv,*minv,*gap;
    maxv = [[Vertex alloc]initWithX:-100 Y:-100 Z:-100];
    minv = [[Vertex alloc]initWithX:100 Y:100 Z:100];
    fp = fopen([filename UTF8String],"r");
    size = [[Vertex alloc] initWithX:1 Y:1 Z:1];
    velocity = [[Vertex alloc]initWithX:0 Y:0 Z:0];
    position = [[Vertex alloc]initWithX:0 Y:0 Z:0];
    direction = [[Vertex alloc]initWithX:0 Y:1 Z:0];
    if(fp == NULL)
    {
        NSLog(@"fp = NULL");
        return;
    }
    char input[100];
    while(1) {
        if(feof(fp)) break;
        fscanf(fp, "%s",input);
        if(strcmp(input, "v")==0)
        {
            fscanf(fp, "%f%f%f",&x,&y,&z);
            v = [[Vertex alloc] initWithX:x Y:y Z:z];
            [vertices addObject:v];
            if( x > maxv.x ) maxv.x = x;
            if( y > maxv.y ) maxv.y = y;
            if( z > maxv.z ) maxv.z = z;
            if( x < minv.x ) minv.x = x;
            if( y < minv.y ) minv.y = y;
            if( z < minv.z ) minv.z = z;
        } else if(strcmp(input,"vt") == 0)
        {
            fscanf(fp, "%f%f",&x,&y);
            v = [[Vertex alloc]initWithX:x Y:y Z:0];
            [textVertices addObject:v];
        } else if(strcmp(input,"f")==0)
        {
            fscanf(fp, "%d/%d/%d%d/%d/%d%d/%d/%d",&v1,&tv1,&n1,&v2,&tv2,&n2,&v3,&tv3,&n3);
            v1--;v2--;v3--;
            tv1--;tv2--;tv3--;
            n1--;n2--;n3--;
            f = [[Face alloc] initWithV1:v1 V2:v2 V3:v3];
            [faces addObject:f];
            f = [[Face alloc] initWithV1:tv1 V2:tv2 V3:tv3];
            [textFaces addObject:f];
            f = [[Face alloc] initWithV1:n1 V2:n2 V3:n3];
            [normalFaces addObject:f];
        } else if(strcmp(input,"vn") == 0)
        {
            fscanf(fp, "%f%f%f",&x,&y,&z);
            v = [[Vertex alloc] initWithX:x Y:y Z:z];
            [normals addObject:v];
        }
    }
 /*   gap = [[Vertex alloc] initWithX:maxv.x-minv.x Y:maxv.y-minv.y Z:maxv.z-minv.z];
    for(Vertex* v in vertices)
    {
        v.x = (v.x-minv.x)/gap.x*size.x-0.5;
        v.y = (v.y-minv.y)/gap.y*size.y-0.5;
        v.z = (v.z-minv.z)/gap.z*size.z-0.5;
    }*/
    buffer_stride = 8*sizeof(GLfloat);
    buffer_size = faces.count*3*buffer_stride;
    buffer = (GLfloat*)malloc(buffer_size);
    vertex_off = 0;
    normal_off = 3;
    text_off = 6;
    vertexNum = [faces count]*3;
    NSLog(@"faces count = %ld",(long)[faces count]);
    NSLog(@"buffer_size = %ld",buffer_size);
    for(int index=0;index<[faces count];index++)
    {
        Face* face = faces[index];
        Face* textface = textFaces[index];
        Face* normalface = normalFaces[index];
        Vertex *v[3],*n[3],*t[3];
        v[0] = vertices[face.v1];
        v[1] = vertices[face.v2];
        v[2] = vertices[face.v3];
        n[0] = normals[normalface.v1];
        n[1] = normals[normalface.v2];
        n[2] = normals[normalface.v3];
        t[0] = textVertices[textface.v1];
        t[1] = textVertices[textface.v2];
        t[2] = textVertices[textface.v3];
        for(int i=0;i<3;i++)
        {
            buffer[8*3*index+i*8+0] = v[i].x/10.0;
            buffer[8*3*index+i*8+1] = v[i].y/10.0;
            buffer[8*3*index+i*8+2] = v[i].z/10.0;
            buffer[8*3*index+i*8+3] = n[i].x;
            buffer[8*3*index+i*8+4] = n[i].y;
            buffer[8*3*index+i*8+5] = n[i].z;
            buffer[8*3*index+i*8+6] = t[i].x;
            buffer[8*3*index+i*8+7] = t[i].y;
        }
    }
    texture = [[Texture alloc]init];
    GLuint textID;
    glGenTextures(1, &textID);
    [texture LoadTextureFileName:textfilename TextureID:textID];
}

-(void) setUp
{
    glGenVertexArraysOES(1, &vertexArray);
    glBindVertexArrayOES(vertexArray);
    
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, buffer_size, buffer, GL_STATIC_DRAW);
    
    /*
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, buffer_stride, BUFFER_OFFSET(vertex_off));

    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, buffer_stride, BUFFER_OFFSET(normal_off));

    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, buffer_stride, BUFFER_OFFSET(text_off));

    glVertexPointer(3, GL_FLOAT, buffer_stride, BUFFER_OFFSET(vertex_off));
    glNormalPointer(GL_FLOAT, buffer_stride, BUFFER_OFFSET(normal_off));
    glTexCoordPointer(2, GL_FLOAT, buffer_stride, BUFFER_OFFSET(vertex_off));
  */
}

-(void) setDirection:(Vertex *)direction
{
    self.direction = direction;
    [self.direction toUnit];
}

-(void) moveByVelocity
{
    self.position.x+=self.velocity.x;
    self.position.y+=self.velocity.y;
    self.position.z+=self.velocity.z;
    NSLog(@"x = %lf\ty = %lf\tz = %lf\n",self.position.x,self.position.y,self.position.z);
}

-(void) drawObj
{
    glPushMatrix();
   /* Vertex* original = [[Vertex alloc] initWithX:0 Y:1 Z:0];
    Vertex* vec = [Vertex multiply:original  cross:direction];
    double angle =acos([Vertex multiply:original dot:direction]);
    glRotatef(angle, vec.x, vec.y, vec.z);
    glTranslatef(position.x, position.y, position.z);*/
    [texture UseTexture];
    glVertexPointer(3, GL_FLOAT, buffer_stride, buffer+vertex_off);
    glNormalPointer(GL_FLOAT, buffer_stride, buffer+normal_off);
    glTexCoordPointer(2, GL_FLOAT, buffer_stride, buffer+text_off);
    glDrawArrays(GL_TRIANGLES, 0, vertexNum);
    glPopMatrix();
}

@end
