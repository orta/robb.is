---
layout: post
title:  About me
color:  40B0D0
---

Hi, my name is **Robert Böhnke**, but you can call me **Robb**.
I'm a mobile developer from Berlin.

If you would like to get in touch with me, send me an e-mail to
[robb@robb.is](mailto:robb@robb.is). You can also follow me on
Twitter where I’m [@ceterum_censeo][twitter].

You can read about some of the tools I use on [usesthis.com][usesthis].

## Projects

Here are some of the things I worked on or am working on now:

<ul>
  <li>
    <a href="http://itunes.apple.com/en/app/soundcloud/id336353151">SoundCloud iOS</a><br>
    The official SoundCloud app for iPhone and iPad
  </li>
  <li>
    <a href="https://play.google.com/store/apps/details?id=com.soundcloud.android">SoundCloud Android</a><br>
    The official SoundCloud app for Android
  </li>
  <li>
    SoundCloud Desktop<br>
    The official SoundCloud app for OS X (discontinued)
  </li>
  <li>
    <a href="http://nerds.fm">nerds.fm</a><br>
    A podcast about programming and technology by <a href="https://twitter.com/343max">Max</a> and yours truly
  </li>
{% for project in site.posts %}
  {% if project.project %}
    <li>
      <a href="{{ project.url }}">{{ project.title }}</a><br>
      {{ project.description}}
    </li>
  {% endif %}
{% endfor %}
</ul>

[soundcloud_android]: https://play.google.com/store/apps/details?id=com.soundcloud.android
[soundcloud_ios]:     http://itunes.apple.com/en/app/soundcloud/id336353151
[soundcloud]:         https://soundcloud.com
[twitter]:            https://twitter.com/ceterum_censeo
[usesthis]:           http://robert.bohnke.usesthis.com
