---
layout: post
title:  About me
color:  E14825
---

Hi, my name is **Robert Böhnke**, but you can call me **Robb**.
I’m a 24-year old developer from Berlin.
I’m working on the [Desktop][soundcloud_desktop] and
[iOS][soundcloud_ios] applications at [SoundCloud][soundcloud] and I study
Computer Science at [Freie Universität Berlin][fu_berlin].

If you would like to get in touch with me, send me an e-mail to
[robb@robb.is](mailto:robb@robb.is). You can also follow me on
Twitter where I’m [@ceterum_censeo][twitter].

You can read about some of the tools I use on [usesthis.com][usesthis].

## Projects

Here are some of the things I worked on or am working on now:

<ul>
  <li>
    <a href="http://itunes.apple.com/en/app/soundcloud/id336353151">SoundCloud iOS</a> – The official SoundCloud app for iPhone and iPad
  </li>
  <li>
    <a href="http://itunes.apple.com/en/app/soundcloud/id412754595">SoundCloud Desktop</a> – The official SoundCloud app for OS X
  </li>
{% for project in site.posts %}
  {% if project.project %}
    <li>
      <a href="{{ project.url }}">{{ project.title }}</a> – {{ project.description}}
    </li>
  {% endif %}
{% endfor %}
</ul>

## Me, elsewhere

* [SoundCloud][soundcloud_profile]
* [Github][github]
* [Twitter][twitter]
* [Vimeo][vimeo]

[soundcloud_desktop]: http://itunes.apple.com/en/app/soundcloud/id412754595
[soundcloud_ios]:     http://itunes.apple.com/en/app/soundcloud/id336353151
[soundcloud]:         https://soundcloud.com
[fu_berlin]:          http://www.fu-berlin.de
[usesthis]:           http://robert.bohnke.usesthis.com

[soundcloud_profile]: https://soundcloud.com/robb
[github]:             https://github.com/robb
[vimeo]:              https://vimeo.com/robb
[twitter]:            https://twitter.com/ceterum_censeo
