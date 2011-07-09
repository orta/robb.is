---
layout:      project
title:       Xylobot
category:    working-on
description: A monome-controlled, xylophone-playing robot
---
I met Ramsey Arnaoot at the Music Hackday Berlin 2009, discussing how underrepresented hardware hacks were, we decided to do something about it and came up with the Xylobot.

The build is nothing special and quite self-explanatory, little hammers made of hot-glued bolts strike the Glockenspiel. The Arduino library suffered from a bug that would let us use only 6 servos, so we had to settle for the major pentatonic scale.

On the computer side, a Java application is listening to incoming MIDI data and triggers the servos using simple serial messages. This was the second project I did with the Arduino and I am still amazed how easily things can be prototyped with this platform. Ramsey wrote a custom Pd-Patch for RjDj to generate music from sensory data, though we haven’t got a video of this.

The Xylobot also was mentioned by Peter in [his Music Hackday wrap-up][cdm_mhd_berlin] on Create Digital Music.

{% embedly http://vimeo.com/6668819 %}

[cdm_mhd_berlin]: http://createdigitalmusic.com/2009/09/wild-musical-inventions-from-berlin-hackday/