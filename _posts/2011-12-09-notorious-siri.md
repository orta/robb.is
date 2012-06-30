---
layout:      project
title:       Notorious Siri
category:    working-on
description: lets Siri spit some wicked lyrics
---

_Notorious Siri_ is my hack for the [Music Hack Day London 2011][mhd].

<div>
  <img src='/img/notorious-siri.png' alt='Notorious Siri' />
</div>

[SiriProxy][siriproxy] is used to intercept the communication with Apple's
servers. Based on your song request, Notorious Siri then sends your choice of
Notorious B.I.G.'s Hypnotize and an a-cappella rendition of Queen's Bohemian
Rhapsody to the device (the latter requiring 4 iPhones 4S).

Siri's speech synthesis is synced to the beat using the timestamps obtained from
the Echonest API which were then manually tweaked, to smooth out delays in the
text-to-speech engine.

<div class="embed" data-url="http://vimeo.com/33402886"></div>

Big thanks to Universal Music for awarding me a nice pair of Dr. Dre headphones

[mhd]:       http://london.musichackday.org/2011/
[siriproxy]: https://github.com/plamoni/SiriProxy
