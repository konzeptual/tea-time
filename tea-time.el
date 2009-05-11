;;; tea-time.el --- Simple timer package.

;; Author: konsty <antipin.konstantin@googlemail.com>
;; Keywords: timer tea-time

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This package allows you to set up time intervals and after this
;; inteval is elapsed Emacs will notify you with sound and notification.
;; It could be useful if you like make a tea or if you would like to
;; be more productive by setting time limit for a task.
;; 
;; If available, notification would be done with great tool
;; mumbles ( http://www.mumbles-project.org )
;; If not, then simply use standard emacs message.

;;; Requirements:

;; tested on Emacs 23

;;; Installation:

;; Add below code in your .emacs
;;
;; (require 'tea-time)
;; (setq tea-time-sound "path-to-sound-file")


;;; Usage:
;;
;; 1. Interactively call (tea-time)
;; 2a. Enter period in minutes if you want to start timer
;; 2b. Press Enter without giving any number - if you would like to know
;; how much time is remaining before the timer expires
;; 
;; Use (tea-timer-cancel) to cancel currently running timer.
;;
;; Suggested binding:
;; (define-key global-map "\C-ct" 'tea-time)


;; That's all.

;;; TODO
;; - What if I want to enter seconds/hours as well?

;;; Code:

;; Origin comes from http://www.hack.org/mc/files/.emacs.el

(defcustom tea-time-sound nil
  "sound that will play once timer is expired.
If you don't have alsa, it is better to be .wav file"
  :group 'tea-time
  :type 'string
  )

(defun tea-timer (sec)
  "Ding and show notification when tea is ready.
Store current timer in a global variable."
  (interactive)
  (run-at-time sec nil (lambda (seconds)
			 (tea-time-play-sound)
			 (show-notification (format "Time is up! %d minutes" (/ seconds 60)))
			 ) sec))

(defun tea-time-play-sound ()
  "Play sound"  
  (if (not (eq nil tea-time-sound))
      (if (program-exists "aplay")
	  (start-process "tea-time-play-notification" nil "aplay" tea-time-sound)
	(play-sound-file tea-time-sound))
    (progn (beep t) (beep t)))
  )

(defun tea-show-remaining-time ()
  "Show how much time is left. If timer is not started - say it."
  (if (not (tea-timer-is-active))
      (message "Timer is not yet started.")
    (let* (
	   (remaining-time (decode-time (time-subtract (timer--time tea-active-timer) (current-time))))
	   (remaining-seconds (nth 0 remaining-time))
	   (remaining-minutes (nth 1 remaining-time))
	   )
      (message "%d min %d sec left" remaining-minutes remaining-seconds)
      )
    ))

(defun tea-timer-cancel ()
  (interactive)
  "Cancel currenly running tea-timer. If not running - do nothing."
  (if (tea-timer-is-active)
      (progn
	(cancel-timer tea-active-timer)
	(makunbound 'tea-active-timer)
	)
    ))

(defun tea-timer-is-active ()
  "Check if we have a running tea-timer."
  (and (boundp 'tea-active-timer) (< (float-time) (float-time (timer--time tea-active-timer))))
  )

(defun tea-time (timeval)
  "Ask how long the tea should draw and start a timer.
Cancel prevoius timer, started by this function"
  (interactive "sHow long (min)? ")
  (if (not (string-match "\\`\\([0-9]+\\)\\'" timeval))
      (tea-show-remaining-time)
    (let* ((minutes (string-to-int (substring timeval (match-beginning 1)
					      (match-end 1))))
	   (seconds (* minutes 60)))
      (progn
	(tea-timer-cancel)
	(setq tea-active-timer (tea-timer seconds))
	)))
  )

(defun show-notification (notification)
  "Show notification. Use mumbles."
  (if (program-exists "mumbles-send")
      (start-process "tea-time-mumble-notification" nil "mumbles-send" notification)
    (message notification)
    ))

(defun program-exists (program-name)
  "Checks whenever we can locate program and launch it."
  (if (eq system-type 'gnu/linux)
      (= 0 (call-process "which" nil nil nil program-name))
    ))

(provide 'tea-time)
;;; tea-time.el ends here

