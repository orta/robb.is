---
title:    Ownership and +1s
category: thinking-about
color:    AA11CC
---

Yesterday, hell froze over.

Many people have written about the change in Apple's external engineering
culture. With the announcement of Swift at WWDC 2014, Apple seemed to have
relaxed its notoriously tight-lipped communications: Chris Lattner is candidly
answering questions in the developer forums, there's a [Swift development
blog][blog] and I've even had a radar resolved! While matters are definitely
changing for the better, a company of Apple's size has insane inertia and good
things take time.

So it comes to little surprise that, when ResearchKit was announced as an Open
Source project, many members of the community were skeptical. But where the
"old" Apple would have handed a zip archive to registered Apple Developers and
called it a day, the new Apple now has a [GitHub account][account].

A GitHub account. Apple.

I don't think anybody would have imagined this two years ago (cue the _never
happened under Steve_) but there's even more: the ResearchKit team ha [expressed
interest][comment] in adding a `podspec` for official CocoaPods support.

I'm glad they understand that in order for ResearchKit to succeed, they need to
get it as many developers' hands as possible and CocoaPods has done a lot to
lower the barrier to entry for using third party dependencies.

However, if Apple can step up their Open Source game, we can too.

The [Pull Request][pr] to add the aforementioned `podspec` file quickly filled
with 👍s. While I understand that those emoji were well intended and only meant
to express support to the cause–hey, it beats duping a radar–the thread got very
noisy very quickly. As someone who maintains some Open Source repos myself, it
pained me to see that the ResearchKit team's first foray into the public iOS
community was met with such clutter.

Again, I'm sure that those 👍s had only the community's best interests in mind,
but I think there is a certain sense of entitlement in our part of the Open
Source world when it comes to support for some random iOS version, the
dependency manager of the day or fixes for arbitrary crashes in your app, which
may or may not be related to the project in question.

Let me tell you, nobody likes to maintain iOS 7 support in their spare time.

Bumping or 👍ing that issue for the twentieth time is probably not going to do
anybody much good. The thread becomes harder to follow for everybody and the
maintainers get more email at best and a sense of guilt at worst.

Open Source projects rarely come with a Service Level Agreement. There are many
reasons to pursue Open Source just as there are many other interesting things in
life. Look at the list of [contributors to your favorite OSS
project][contributors] and imagine what would happen if they all pulled a
[__why], as they have every right to.

If you decide to incorporate someones project into your app, especially if you
write said app as part of your day job, you have to be willing to support that
project when the poop emoji hits the fan. That can mean using your own time and
engineering resources or financially supporting said contributors. I don't think
many people would balk at the opportunity to get paid for working on something
they started out of their own curiosity.

But maybe you don't have the knowledge necessary to support every project.
That's cool. If you don't think you have the skills to fix a problem yourself,
try regardless. _A Pull Request will always get you further than an Issue_. Even
if it breaks the build, it shows that you value the maintainers' time highly
enough to match it with some of your own. It's also a great opportunity to
familiarize yourself with a code base and learn a thing or two.

For all we know, ResearchKit could disappear tomorrow, I don't think it will but
stranger things have happened. If you build the next big thing on top of it, or
AFNetworking, or ReactiveCocoa, or whatever other project you think is cool, you
should really have a contingency plan that consists of more than emoji.

[blog]: https://developer.apple.com/swift/blog/
[account]: https://github.com/ResearchKit
[comment]: https://github.com/ResearchKit/ResearchKit/pull/5#issuecomment-93217208
[pr]: https://github.com/ResearchKit/ResearchKit/pull/5
[contributors]: https://github.com/ReactiveCocoa/ReactiveCocoa/graphs/contributors
[__why]: https://en.wikipedia.org/wiki/Why_the_lucky_stiff
