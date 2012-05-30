---
layout:      post
title:       My dotfiles
category:    working-on
description: I've open-sourced my dotfiles
---

After using [oh_my_zsh][oh_my_zsh] for quite a while, I recently switched to
having [my own repo][dotfiles] to store my dotfiles.
I got a better understanding of zsh and its customization, now there is no
suprising alias that I didn't know of.

My prompt now looks something like this:

<img src='/img/prompt.png' alt='My prompt'/>

The right-hand side contains all relevant information about my currrent repo.
The red circle indicates that I have untracked files but it being empty means
nothing is staged.<br />
The color indicates the time since the last commit, more than 30 minutes in this
case.<br />
It also tells me the branch I am on or the SHA1 of the current HEAD, if I am in
'detached HEAD' state.

You can find my prompt [here][prompt], if you would like to use some of it for
your own shell.

[oh_my_zsh]: https://github.com/robbyrussell/oh-my-zsh
[dotfiles]:  https://github.com/robb/.dotfiles
[prompt]:    https://github.com/robb/.dotfiles/blob/master/zsh/prompt.zsh
