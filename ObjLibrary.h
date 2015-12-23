//
//  ObjLibrary.h
//  Stereopsis
//
//  Created by drinking on 12/11/15.
//  Copyright © 2015 drinking. All rights reserved.
//

#ifndef ObjLibrary_h
#define ObjLibrary_h

class ObjLibrary {
public:
    enum {
        PRIEST,
        ROBOT1,
        ROBOT2,
        BIRD,
        OBJNum
    };

    static NSString* objnames[OBJNum];

    static NSString* textnames[OBJNum];
};

#endif /* ObjLibrary_h */
