;;; doc-view.el --- View PDF/PostStript/DVI files in Emacs

;; Copyright (C) 2007 Tassilo Horn
;;
;; Author: Tassilo Horn <[EMAIL PROTECTED]>
;; Homepage: http://www.tsdh.de

;; This  program is free  software; you  can redistribute  it and/or  modify it
;; under the terms  of the GNU General Public License as  published by the Free
;; Software  Foundation;  either version  3,  or  (at  your option)  any  later
;; version.
;;
;; This program is distributed in the  hope that it will be useful, but WITHOUT
;; ANY  WARRANTY;  without even  the  implied  warranty  of MERCHANTABILITY  or
;; FITNESS FOR  A PARTICULAR PURPOSE.  See  the GNU General  Public License for
;; more details.
;;
;; You should have received a copy of the GNU General Public License along with
;; this program; if not, write to  the Free Software Foundation, Inc., 675 Mass
;; Ave, Cambridge, MA 02139, USA.

;;; Requirements:

;; I tested in on GNU Emacs 22, but maybe it works with older emacsen or
;; XEmacs, too.  You need ImageMagick's convert tool.

;;; Commentary:

;; DocView is a  document viewer for Emacs.  It converts PDF,  PS and DVI files
;; to a set  of PNG files, one PNG  for each page, and displays  the PNG images
;; inside  an Emacs buffer.   This buffer  uses `doc-view-mode'  which provides
;; convenient key bindings for browsing the document.
;;
;; To use it simply do
;;
;;     M-x doc-view RET
;;
;; and you'll be queried for a document to open.
;;
;; Since  conversion may take  some time  all the  PNG images  are cached  in a
;; subdirectory of `doc-view-cache-directory' and  reused when you want to view
;; that  file again.   This  reusing can  be  omitted if  you  provide a  prefx
;; argument    to   `doc-view'.     To    delete   all    cached   files    use
;; `doc-view-clear-cache'.  To open the cache  with dired, so that you can tidy
;; it out use `doc-view-dired-cache'.

;;; Version:

;; <2007-08-22 Wed 19:06>

;;; Code:

(defgroup doc-view
  nil
  "In-buffer viewer for PDF, PostScript and DVI files.")

(defcustom doc-view-converter-program "convert"
  "Program to convert doc files to png."
  :type '(file)
  :group 'doc-view)

(defcustom doc-view-cache-directory "/tmp/doc-view"
  "The base directory, where the PNG imoges will be saved."
  :type '(directory)
  :group 'doc-view)

(defcustom doc-view-display-size 114
  "The DPI your screen supports.
This value determinate how big the resulting PNG images are.  If
the value is too small, reading might become hard.  If it's too
big, the images won't fit into an Emacs buffer.  Fiddle with it!"
  :type '(integer)
  :group 'doc-view)

(defcustom doc-view-display-margin 5
  "The width of the margin put around the page's image."
  :type '(integer)
  :group 'doc-view)

(defvar doc-view-current-files nil
  "Only used internally.")

(defvar doc-view-current-page nil
  "Only used internally.")

(defvar doc-view-current-dir nil
  "Only used internally.")


;; (defparameter doc-view-mode-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "C-v") 'doc-view-next-page)
;;     (define-key map (kbd "M-v") 'doc-view-previous-page)
;;     (define-key map (kbd "M-<") 'doc-view-first-page)
;;     (define-key map (kbd "M->") 'doc-view-last-page)
;;     (define-key map (kbd "g")   'doc-view-goto-page)
;;     (define-key map (kbd "k")   'doc-view-kill-buffer)
;;     (define-key map (kbd "q")   'bury-buffer)
;;     (suppress-keymap map)
;;     map)
;;   "Keymap used by `doc-view-mode'.")

(defun doc-view-kill-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(defun doc-view-goto-page (arg)
  "View the page given by ARG.
DocView numbers pages starting with zero!"
  (interactive "nPage: ")
  (doc-view-display-image (nth arg doc-view-current-files))
  (setq doc-view-current-page arg))

(defun doc-view-next-page (arg)
  "Browse ARG pages forward."
  (interactive "p")
  (let ((page (+ doc-view-current-page arg)))
    (if (< page 0)
        (setq page 0)
      (when (>= page (length doc-view-current-files))
        (setq page (1- (length doc-view-current-files)))))
    (doc-view-goto-page page)))
