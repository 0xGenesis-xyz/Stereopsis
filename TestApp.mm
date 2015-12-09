//
//  TestApp.cpp
//  Stereopsis
//
//  Created by 张函祎 on 15/12/7.
//  Copyright © 2015年 Sylvanus. All rights reserved.
//

#include <string>
#include "TestApp.hpp"
#include "PointCloud.h"

TestApp::TestApp(int viewport_width, int viewport_height,
                 int video_width, int video_height,
                 pointcloud_video_format video_format,
                 const char* resource_path,
                 const char* documents_path,
                 const char* device,
                 double ui_scale_factor) :
PointCloudApplication(viewport_width, viewport_height,
                      video_width, video_height,
                      video_format,
                      resource_path,
                      documents_path,
                      device,
                      ui_scale_factor)
{
    setup_cuboid();
    
    // Add images to look for (detection will not start until images are activated, though)
    std::string image_target_1_path = resource_path + std::string("image_target_1.model");
    std::string image_target_2_path = resource_path + std::string("image_target_2.model");
    
    pointcloud_add_image_target("image_1", image_target_1_path.c_str(), 0.3, -1);
    pointcloud_add_image_target("image_2", image_target_2_path.c_str(), 0.3, -1);
    
    pointcloud_reset();
    pointcloud_enable_map_expansion();
    pointcloud_activate_image_target("image_1");
    pointcloud_activate_image_target("image_2");
}


// Most convoluted way to make a cuboid
void TestApp::setup_cuboid() {
    /*
    float corners[8][3];
    float normals[6][3];
    
    double len = 0.1;
    
    for (int i = 0; i < 8; i++) {
        corners[i][0] = -len/2;
        corners[i][1] = 0;
        corners[i][2] = -len/2;
    }
    
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 3; j++) {
            normals[i][j] = 0;
        }
    }
    
    normals[0][0] = 1;
    normals[1][2] = 1;
    normals[2][1] = 1;
    normals[3][0] = -1;
    normals[4][2] = -1;
    normals[5][1] = -1;
    
    corners[1][0] += len;
    corners[2][0] += len;
    corners[5][0] += len;
    corners[6][0] += len;
    
    corners[2][2] += len;
    corners[3][2] += len;
    corners[6][2] += len;
    corners[7][2] += len;
    
    corners[4][1] += len*3;
    corners[5][1] += len*3;
    corners[6][1] += len*3;
    corners[7][1] += len*3;
    
    int strip[] = {4,0,5,1,6,2,7,3,4,0,0,1,3,2,2,6,7,5,4};
    int side[] =  {4,4,4,4,0,0,1,1,3,3,5,5,5,5,2,2,2,2,2};
    
    for (int i = 0; i < sizeof(strip)/sizeof(int); i++) {
        int c = strip[i];
        int s = side[i];
        for (int j = 0; j < 3; j++) {
            cuboid_vertices[i][j] = corners[c][j];
            cuboid_normals[i][j] = normals[s][j];
        }
    }*/
    NSString *objpath = [[NSBundle mainBundle] pathForResource:@"arcanegolem" ofType:@"obj"];
    if(objpath == nil) NSLog(@"Path to obj not found");
    NSString *textpath = [[NSBundle mainBundle] pathForResource:@"AG_Model_Mesh_ArcaneDefense" ofType:@"tga"];
    if(objpath == nil) NSLog(@"Path to texture image not found");
    objs[PRIEST] = [[OBJ alloc] init];
    [objs[PRIEST] loadObj:objpath Texture:textpath];
    //[objs[PRIEST] setUp];
}


void TestApp::render_content(double time_since_last_frame) {
    
    pointcloud_state state = pointcloud_get_state();
    
    // Draw the content if we have SLAM or image tracking
    if (state == POINTCLOUD_TRACKING_SLAM_MAP || state == POINTCLOUD_TRACKING_IMAGES) {
        
        switch_to_camera();
        
        // Set light position
        glEnable(GL_LIGHTING);
        glEnable(GL_LIGHT0);
        static const GLfloat LightWhite[] = {1,1,1,1};
        static const float light_position[4] = {1, 1, 0.5, 0.0f};
        glLightfv(GL_LIGHT0, GL_POSITION, light_position);
        glLightfv(GL_LIGHT0, GL_DIFFUSE, LightWhite);
        glLightfv(GL_LIGHT0, GL_AMBIENT, LightWhite);
   //     glColor4f(1,0,0,1);
        
  //      glDisable(GL_TEXTURE_2D);
        glEnable(GL_TEXTURE_2D);

        glEnable(GL_COLOR_MATERIAL);
        glShadeModel(GL_FLAT);
        
        glEnableClientState(GL_VERTEX_ARRAY);
        glEnableClientState(GL_NORMAL_ARRAY);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
/*
        glVertexPointer(3, GL_FLOAT, 0, (float *)cuboid_vertices);
        glNormalPointer(GL_FLOAT, 0, (float *)cuboid_normals);
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 19);
 */
        [objs[PRIEST] drawObj];
        
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
        glDisableClientState(GL_NORMAL_ARRAY);
        glDisableClientState(GL_VERTEX_ARRAY);
        
        glShadeModel(GL_SMOOTH);
        glDisable(GL_TEXTURE_2D);
        glDisable(GL_COLOR_MATERIAL);
        glColor4f(1, 1, 1, 1);
    }
}

bool TestApp::on_touch_started(double x, double y) {
    return false;
}

bool TestApp::on_touch_moved(double x, double y) {
    return false;
}

bool TestApp::on_touch_ended(double x, double y) {
    return false;
}

bool TestApp::on_touch_cancelled(double x, double y) {
    return false;
}
