// Copyright (c) 2014 Alejandro Isaza
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AIDefer.h"
#import <XCTest/XCTest.h>


// Simulates the state of a resource
static BOOL resource_open = NO;

// Marks that the resource has been used
static BOOL resource_used = NO;


@interface AIDeferTests : XCTestCase

@end

@implementation AIDeferTests

- (void)testDefer {
    // A runloop needs to be active for the autorelease pool
    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];

    // Initially the resource is closed and hasn't been used
    XCTAssertFalse(resource_open);
    XCTAssertFalse(resource_used);

    // Use the resource, needs to run inside the run loop
    [self performSelector:@selector(resourceAction) withObject:nil afterDelay:0];

    // Wait for the resource to be used, with a timeout
    NSTimeInterval timeoutTime = [[NSDate dateWithTimeIntervalSinceNow:1.] timeIntervalSinceReferenceDate];
    while (!resource_used) {
        [runLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1f]];
        if ([NSDate timeIntervalSinceReferenceDate] > timeoutTime) {
            XCTFail(@"Test timed out!");
            break;
        }
    }

    // By now the resource should have been used and be closed
    XCTAssertTrue(resource_used);
    XCTAssertFalse(resource_open);
}

- (void)resourceAction {
    // Open a resource
    resource_open = YES;

    // Defer closing the resource
    defer(^() {
        resource_open = NO;
    });

    XCTAssertTrue(resource_open);
    resource_used = YES;
}

@end
