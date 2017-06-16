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

#define IDPWeakify(variable) \
    __weak __typeof(variable) __IDPWeakified_##variable = variable;

// you should only call this method after you called weakify for the same variable
#define IDPStrongify(variable) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wshadow\"");\
    __strong __typeof(variable) variable = __IDPWeakified_##variable \
    _Pragma("clang diagnostic pop");

#define IDPEmptyResult

#define IDPStrongifyAndReturnIfNil(variable) \
    IDPStrongifyAndReturnResultIfNil(variable, IDPEmptyResult)

#define IDPStrongifyAndReturnNilIfNil(variable) \
    IDPStrongifyAndReturnResultIfNil(variable, nil)

#define IDPStrongifyAndReturnResultIfNil(variable, result) \
    IDPStrongify(variable); \
    if (!variable) { \
        return result; \
    }
