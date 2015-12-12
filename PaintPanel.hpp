//
//  TestApp.hpp
//  Stereopsis
//
//  Created by 张函祎 on 15/12/7.
//  Copyright © 2015年 Sylvanus. All rights reserved.
//

#ifndef PaintPanel_hpp
#define PaintPanel_hpp

#include "PointCloudApplication.hpp"
#include "TextureUtilities.hpp"
#include "ObjLibrary.h"
#import "OBJ.h"
//#inlude <math.h>

class PaintPanel : public PointCloudApplication {
    
private:
    void setup_objs();
    double init_fadeout_time;
    OBJ* objs[ObjLibrary::OBJNum];
    GLfloat floatTime = 0;
    int selectedModel;
protected:
    virtual void render_content(double time_since_last_frame);
    
public:

    PaintPanel(int viewport_width, int viewport_height,
            int video_width, int video_height,
            pointcloud_video_format video_format,
            const char* resource_path,
            const char* documents_path,
            const char* device,
            double ui_scale_factor,
               int selectedModel);
    
    virtual bool on_touch_started(double x, double y);
    virtual bool on_touch_moved(double x, double y);
    virtual bool on_touch_ended(double x, double y);
    virtual bool on_touch_cancelled(double x, double y);
    
};

#endif /* PaintPanel_hpp */
