---
layout: post
title:  About me
---

Hi, my name is **Robert Böhnke**, but you can call me **Robb**.
I’m a 22-year old developer from Berlin.
I’m working on the [SoundCloud Desktop][soundcloud_desktop] application and I study Computer Science at [Freie Universität Berlin][fu_berlin].

If you want to get in touch with me, send me an e-mail to [robert.boehnke@gmail.com](mailto:robert.boehnke@gmail.com). You can also follow me on Twitter where I’m [@ceterum_censeo][twitter].

## Projects

Here are some of the things I worked on or am working on now:

<ul>
  <li>
    <a href="http://itunes.apple.com/en/app/soundcloud/id412754595">SoundCloud Desktop</a>
  </li>
{% for project in site.posts %}
  {% if project.layout == 'project' %}
    <li>
      <a href="{{ project.url }}">{{ project.title }}</a>
    </li>
  {% endif %}
{% endfor %}
</ul>

## Me, elsewhere

* [SoundCloud][soundcloud]
* [Github][github]
* [Twitter][twitter]
* [Vimeo][vimeo]

[soundcloud_desktop]: http://soundcloud.com/apps/soundcloud-desktop
[fu_berlin]:          http://www.fu-berlin.de

[soundcloud]: https://soundcloud.com/robb
[github]:     https://github.com/robb
[vimeo]:      https://vimeo.com/robb
[twitter]:    https://twitter.com/ceterum_censeo
