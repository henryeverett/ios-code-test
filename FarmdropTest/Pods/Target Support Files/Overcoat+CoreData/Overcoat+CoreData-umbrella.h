#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "OVCManagedHTTPSessionManager.h"
#import "OVCManagedModelResponseSerializer.h"
#import "OVCManagedObjectSerializingContainer.h"
#import "OVCManagedStore.h"
#import "OvercoatCoreData.h"

FOUNDATION_EXPORT double OvercoatCoreDataVersionNumber;
FOUNDATION_EXPORT const unsigned char OvercoatCoreDataVersionString[];

