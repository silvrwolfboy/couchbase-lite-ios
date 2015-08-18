//
//  CBLAttachmentDownloader.h
//  CouchbaseLite
//
//  Created by Jens Alfke on 8/3/15.
//  Copyright (c) 2015 Couchbase, Inc. All rights reserved.
//

#import "CBLRemoteRequest.h"
@class CBLDatabase, CBL_AttachmentRequest;

typedef void (^CBLAttachmentDownloaderProgressBlock)(uint64_t bytesRead,
                                                     uint64_t contentLength,
                                                     NSError* error);

@interface CBLAttachmentDownloader : CBLRemoteRequest

- (instancetype) initWithDbURL: (NSURL*)dbURL
                      database: (CBLDatabase*)database
                    attachment: (CBL_AttachmentRequest*)attachment
                      progress: (NSProgress*)progress
                  onCompletion: (CBLRemoteRequestCompletionBlock)onCompletion;

- (void) addProgress: (NSProgress*)progress;
- (void) removeProgress: (NSProgress*)progress;

#if DEBUG
extern BOOL CBLAttachmentDownloaderFakeTransientFailures;
@property BOOL fakeTransientFailure;    // for testing only; causes one fake failure during DL
#endif

@end
