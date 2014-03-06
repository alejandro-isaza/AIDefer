AIDefer is a code execution deferring system inspired on [Go](http://golang.org)'s [defer](http://golang.org/doc/effective_go.html#defer) statement.

[![Build Status](https://travis-ci.org/aleph7/AIDefer.png)](https://travis-ci.org/aleph7/AIDefer)


## Usage

Use `defer` to postpone the execution of a block. This is useful when dealing with resources that needs to be released at a later point. Here is an example using locks:

```objc
- (Person*)personAtIndex:(NSUInteger)index {
    [_lock lock];
    defer(^() {
        [_lock unlock];
    });
    
    return [_array objectAtIndex:index];
}
```

The lock is aquired at the start of the method and the unlock is postponed until the method returns. See [the blog post](http://www.a-coding.com/2014/03/defer-in-objective-c.html) for more information.


## Installation

To use in your project simply copy the `AIDefer.h` and `AIDefer.m` files into your project. If you are using [CocoaPods](http://cocoapods.org) add this to your Podfile:

```ruby
pod "AIDefer", "~> 1.0"
```
