## Tea-time
Tea-time is an extention to emacs.
Kind of analog of gnome applet tea-time http://det.cable.nu/teatime/index.rbx?r=2.8.0

It allows you to set up time intervals and after this
interval is elapsed, Emacs will notify you with sound and    notification.
It could be useful if you make a tea or if you would like to
be more productive by setting time limit for a task.

If available, notification would be done with great tool
mumbles ( http://www.mumbles-project.org )
If not, then simply use standard emacs message.

## Requirements:

 tested on Emacs 23,
 should work on any version.

## Installation:

1. Add the code below in your .emacs
   (require 'tea-time)
2. Customize variable tea-time-sound via M-x customize or simply  put (setq tea-time-sound "path-to-sound-file") in .emacs


## Usage:

* Interactively call (tea-time)
 
	* Enter period in minutes if you want to start timer   
	* Or press Enter without giving any number - if you would like to   know how much time is remaining before the timer expires
 
* Use (tea-timer-cancel) to cancel currently running timer.

* Suggested binding:
 (define-key global-map "\C-ct" 'tea-time)
