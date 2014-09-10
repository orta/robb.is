---
title:    RBBAnimation
category: working-on
project:  true
color:    5050C0
description: Block-based animations made easy.
---

[RBBAnimation] is a subclass of `CAKeyframeAnimation` that allows you to use
blocks to describe your animation instead of having to write out every frame by
hand.

It comes out of the box with a replacement for CASpringAnimation, support for
custom easing functions such as bouncing as well as hooks to allow you to write
your own animations fully from scratch.

### RBBCustomAnimation

`RBBCustomAnimation` is the most flexible of the `RBBAnimation` subclasses.
To use it, simply create a new animation as you normally would
an pass in an `RBBAnimationBlock` from which you return the desired value for a
given point in time.

<div class="image white background">
    <img src="/img/rbbanimation/rainbow.gif" alt="RBBCustomAnimation">
</div>

{% highlight objective-c %}
animation.animationBlock = ^(CGFloat elapsed, CGFloat duration) {
    UIColor *color = [UIColor colorWithHue:elapsed / duration
                                saturation:1
                                brightness:1
                                     alpha:1];

    return (id)color.CGColor;
};
{% endhighlight %}

That being said, you'll probably want to use the higher-level
`RBBTweenAnimation`.

### RBBTweenAnimation

`RBBTweenAnimation` is similar to `CABasicAnimation` in that it smoothly
interpolates between two values. Unlike CABasicAnimation however, it supports a
wider variety of easing functions.

Easing functions (or timing functions) are used to describe how fast values
change during an animation. Core Animation comes with the
`CAMediaTimingFunction` class, but it's limited to cubic Bézier curves.

They are also available for `RBBTweenAnimation` through the RBBCubicBezier
helper:

<div class="image white background">
    <img src="/img/rbbanimation/ease-in-out-back.gif" alt="RBBCubicBezier(0.68, -0.55, 0.265, 1.55)">
</div>

{% highlight objective-c %}
animation.easing = RBBCubicBezier(0.68, -0.55, 0.265, 1.55);
animation.duration = 0.6;
{% endhighlight %}

However, `RBBTweenAnimation` also supports more complex easing functions such as
`RBBEasingFunctionEaseOutBounce`:

<div class="image white background">
    <img src="/img/rbbanimation/bounce.gif" alt="RBBEasingFunctionEaseOutBounce">
</div>

{% highlight objective-c %}
animation.easing = RBBEasingFunctionEaseOutBounce;
animation.duration = 0.8;
{% endhighlight %}

If you fancy, you can also specify your own easing functions, like this sine
wave here, from scratch:

<div class="image white background">
    <img src="/img/rbbanimation/sine-wave.gif" alt="Custom easing function">
</div>

{% highlight objective-c %}
animation.easing = ^CGFloat (CGFloat fraction) {
    return sin((fraction) * 2 * M_PI);
};
{% endhighlight %}

### RBBSpringAnimation

While Core Animation comes with a `CASpringAnimation` class to model damped
springs, it's private API and thus (more or less) off-limits, quite a shame
since it's a really gorgeous effect.

I've implemented `RBBSpringAnimation` as a replacement, simply specify the
springs `mass`, `damping`, `stiffness` as well as its initial velocity and watch
it go:

<div class="image white background">
    <img src="/img/rbbanimation/spring.gif" alt="RBBSpringAnimation">
</div>

{% highlight objective-c %}
RBBSpringAnimation *animation = [RBBSpringAnimation animationWithKeyPath:@"position.y"];

animation.velocity = 0;
animation.mass = 1;
animation.damping = 10;
animation.stiffness = 100;
{% endhighlight %}

You can [find the code on GitHub][RBBAnimation], it's MIT licensed and also
available [through CocoaPods][pod].

I hope RBBAnimation will be useful to you. If you end up using it in one of your
apps, I'd love to hear about that.

[RBBAnimation]: https://github.com/robb/RBBAnimation
[pod]: https://github.com/CocoaPods/Specs/tree/master/RBBAnimation
