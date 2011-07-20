---
layout:      post
title:       More embed.ly goodness
category:    working-on
---

I’ve added a new small feature to the [embed.ly plug-in][plug-in], now you can
pass along parameters specific to a particular embed, e.g.

<pre><code>{<!-- -->% embedly http://soundcloud.com/battles/ice-cream, color: FF11FF %}
{<!-- -->% embedly http://soundcloud.com/workit/the-drums-money, color: FFCC00 %}
{<!-- -->% embedly http://soundcloud.com/modularpeople/the-avalanches-since-i-left-you-stereolab-remix, color: 00CCFF %}</code></pre>

will produce

{% embedly http://soundcloud.com/battles/ice-cream, color: FF11FF, player_type: default %}
{% embedly http://soundcloud.com/workit/the-drums-money, color: FFCC00, player_type: default %}
{% embedly http://soundcloud.com/modularpeople/the-avalanches-since-i-left-you-stereolab-remix, color: 00CCFF, player_type: default %}

Hooray for colorful SoundCloud players!

[plug-in]: /working-on/embedly-and-jekyll
