//
//  TestApp.hpp
//  Stereopsis
//
//  Created by 张函祎 on 15/12/7.
//  Copyright © 2015年 Sylvanus. All rights reserved.
//

#ifndef TestApp_hpp
#define TestApp_hpp

#include "PointCloudApplication.hpp"
#include "TextureUtilities.hpp"
#import "OBJ.h"

class TestApp : public PointCloudApplication {
    
private:
    float cuboid_vertices[19][3];
    float cuboid_normals[19][3];
    
    void setup_cuboid();
    double init_fadeout_time;
    
    enum {
        PRIEST,
        OBJNUM
    };
    OBJ* objs[OBJNUM];
    
protected:
    virtual void render_content(double time_since_last_frame);
    
public:
    
    TestApp(int viewport_width, int viewport_height,
            int video_width, int video_height,
            pointcloud_video_format video_format,
            const char* resource_path,
            const char* documents_path,
            const char* device,
            double ui_scale_factor);
    
    virtual bool on_touch_started(double x, double y);
    virtual bool on_touch_moved(double x, double y);
    virtual bool on_touch_ended(double x, double y);
    virtual bool on_touch_cancelled(double x, double y);
    
};

#endif /* TestApp_hpp */
