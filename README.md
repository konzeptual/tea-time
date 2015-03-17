## Tea-time

Tea-time is an extention to emacs.
Kind of analog of
[gnome applet tea-time](http://www.t2-project.org/packages/teatime.html)

It allows you to set up time intervals and after this interval is
elapsed, Emacs will notify you with sound and notification. It could
be useful if you make a tea or if you would like to be more productive
by setting time limit for a task.

If available, notification would be done with great tool
[mumbles](https://github.com/xiongchiamiov/mumbles) If not, then
simply use standard emacs message.

## Requirements:

Tested on Emacs:

* 23
* 24.4

Should work on any version.

## Installation:

1. Download from http://github.com/krick/tea-time/tree/master, or
simply `git clone git://github.com/krick/tea-time.git`

2. Add tea-time directory to the load path, if needed
``` elisp
(add-to-list "path-to-tea-time"))
```

3. Add the code below in your .emacs
``` elisp
(require 'tea-time)
```

4. Customize variable `tea-time-sound` via `M-x customize`
or simply put in .emacs
``` elisp
(setq tea-time-sound "path-to-sound-file")
```

## Usage:

* Interactively call `(tea-time)`
    * Enter period in minutes if you want to start timer
    * Or press Enter without giving any number if you would like to
    know how much time is remaining before the timer expires
* Use `(tea-timer-cancel)` to cancel currently running timer.
* Suggested binding:
``` elisp
(define-key global-map "\C-ct" 'tea-time)
```
