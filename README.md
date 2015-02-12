AIDefer is a code execution deferring system inspired on [Go](http://golang.org)'s [defer](http://golang.org/doc/effective_go.html#defer) statement. As an alternative you may want to consider using [libextobjc](https://github.com/jspahrsummers/libextobjc)'s [@onExit](https://github.com/jspahrsummers/libextobjc/blob/master/extobjc/EXTScope.h#L31)

[![Build Status](https://travis-ci.org/aleph7/AIDefer.png)](https://travis-ci.org/aleph7/AIDefer)


## Usage

Use `defer` to postpone the execution of a block. This is useful when dealing with resources that need to be released at a later point. Here is an example for using a lock:

```objc
- (Person*)personAtIndex:(NSUInteger)index {
    [_lock lock];
    defer(^() {
        [_lock unlock];
    });
    
    return [_array objectAtIndex:index];
}
```

The lock is aquired at the start of the method and the unlock is postponed until the method returns. See [the blog post](http://a-coding.com/defer-in-objective-c/) for more information.


## Installation

To use in your project simply copy the `AIDefer.h` and `AIDefer.m` files into your project. If you are using [CocoaPods](http://cocoapods.org) add this to your Podfile:

```ruby
pod "AIDefer", "~> 1.0.2"
```
