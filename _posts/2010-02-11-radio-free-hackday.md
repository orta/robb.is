---
layout:      project
title:       Radio Free Hackday
category:    working-on
---
This is a project my friend Simon and I worked on during Music Hackday Stockholm in early 2010.

We wanted to come up with a physical interface for online music consumption. After a bit of research into various devices, we found the Panasonic RF-2400 and instantly fell in love with its iconic appearance. (It couldn’t look more like a radio, could it?)

We removed the power supply to make room for an Arduino Mini running a custom firmware and shortwired the frequency dial so that the radio is always tuned to the same frequency, no matter which frequency the user selected.

We then read out the position of the dial with the Arduino and sent it to the computer via USB. The computer would then stream music from the [Citysounds.fm][citysounds] and [SoundCloud][soundcloud] APIs back into the device using a FM Transmitter.

We got very positive feedback for our hack, [Create Digital Music][cdm_mhd_sthml] wrote about it, we won two nice prizes from [Pacemaker][pacemaker] and even got featured on Sweden’s public TV station, SVT:

<iframe src="http://player.vimeo.com/video/9491104?byline=1&portrait=1&color=0066FF" width="600" height="338" frameborder="0">
  
</iframe>
  Please skip to 02:30 (Vimeo doesn’t allow for timed embeds).

[soundcloud]: http://soundcloud.com
[citysounds]: http://citysounds.fm
[cdm_mhd_sthml]: http://createdigitalmusic.com/2010/02/diy-community-your-web-connected-musical-future-at-music-hackday-stockholm/