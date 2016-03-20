(in-package #:alice)

(register-matcher :whois
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (or (mentions "who is" (unquoted-part input))
                                                (mentions "who am i" (unquoted-part input)))))))
                  (lambda (input)
                    (if (mentions "who am i" (unquoted-part input))
                        (say (reply-to input) (identify-person-canonical-name (author input)) :to (author input))
                        (if (identify-person-mentioned (unquoted-part input))
                            (say (reply-to input) (identify-person-canonical-name (identify-person-mentioned (unquoted-part input))) :to (author input))
                            (say (reply-to input) "Not sure I know who are you asking about..." :to (author input)))))) ;FIXME string constant to remove

;; temporary control for remembering names
;;; NOTE remains untranslated on purpose.
(register-matcher :assign-name-alias
                  (list (match-score (lambda (input)
                                       (and (not (publicp input))
                                            (mentions "zapamiętaj:" (unquoted-part input))))))
                  (lambda (input)
                    (let* ((names (extract-words (unquoted-part input)))
                           (alias (second names))
                           (canonical (third names)))
                      (if (and alias canonical)
                          (progn
                            (learn-canonical-name alias canonical)
                            (say (reply-to input) (format nil "Zapamiętałam ~A jako ~A." alias canonical)))
                          (say (reply-to input) "You fail at wydawanie poleceń. *sigh*")))))
