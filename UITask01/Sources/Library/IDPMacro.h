//
//  IDPMacro.h
//  UITask01
//
//  Created by Student003 on 6/13/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#define IDPBaseViewProperty(viewName, viewClass) \
@property (nonatomic, readonly) viewClass *viewName;

#define IDPBaseViewGetterSynthesize(viewName, viewClass) \
    - (viewClass *)viewName { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
            return (viewClass *)self.view; \
        } \
    \
    return nil; \
    }

#define IDPViewController(viewControllerClass, viewName, viewClass) \
    @interface viewControllerClass (__IDPPrivateBaseView) \
    IDPBaseViewProperty(viewName, viewClass) \
    \
    @end \
    \
    @implementation viewControllerClass (__IDPPrivateBaseView) \
    \
    @dynamic viewName;\
    \
    IDPBaseViewGetterSynthesize(viewName, viewClass) \
    \
    @end
