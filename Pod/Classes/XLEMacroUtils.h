//
//  XLEMacroUtils.h
//  Pods
//
//  Created by Randy on 16/2/20.
//
//

#ifndef XLEMacroUtils_h
#define XLEMacroUtils_h

// 两种 weakself 写法
#define __XLEWeakSelf__  __weak typeof (self)

#define XLEWS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


#define __XLEWeakObject(object) __weak typeof (object)

#define xleWeakifyself __XLEWeakSelf__ wSelf = self;
#define xleStrongifyself __XLEWeakSelf__ self = wSelf;

#define xleWeakifyobject(obj) __XLEWeakObject(obj) $##obj = obj;
#define xleStrongifobject(obj) __XLEWeakObject(obj) obj = $##obj;

#endif /* XLEMacroUtils_h */
