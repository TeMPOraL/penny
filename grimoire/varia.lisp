(in-package #:alice)

;;; Marisa Kirisame overreaction.
#+nil(register-matcher :marisa
                  (list (match-score (lambda (input)
                                       (or (mentions "kirisame" (raw-text input))
                                           (mentions "marisa" (raw-text input))))
                                     999))
                  (lambda (input) (say (reply-to input) :marisa)))

;;; Introductions.
(register-matcher :introductions
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (or (mentions "introduce" (unquoted-part input))
                                                (mentions "introduce yourself" (unquoted-part input))
                                                (mentions "say hello" (unquoted-part input))
                                                (mentions "who are you"  (unquoted-part input)))))))
                  (lambda (input) (say (reply-to input) :introduction)))

;;; Version number.
(register-matcher :version
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (or (mentions "version number" (unquoted-part input))
                                                (mentions "version" (unquoted-part input)) ;FIXME how about regexp?
                                                ;; (mentions "wersja" (unquoted-part input))
                                                ;; (mentions "wersją" (unquoted-part input))
                                                ;; (mentions "wersję" (unquoted-part input))
                                                )))))
                  (lambda (input) (say (reply-to input) :version)))

;;; Be nice to thanks.
(register-matcher :thanks-reply
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (or (mentions "thx" (unquoted-part input))
                                                (mentions "thanks" (unquoted-part input))
                                                (mentions "thank you" (unquoted-part input))
                                                (mentions "dzieki" (unquoted-part input))
                                                (mentions "dzięki" (unquoted-part input))
                                                (mentions "dziekuje" (unquoted-part input))
                                                (mentions "dziękuje" (unquoted-part input))
                                                (mentions "dziękuję" (unquoted-part input)))))
                                     0.9))
                  (lambda (input)
                    (say (reply-to input) :thanks-reply)
                    (when (or (mentions ":*" (unquoted-part input))
                              (mentions "sło" (unquoted-part input)))
                      (say (reply-to input) :blush))))

;;; Those are not needed now anyway.
;; ;; temp check
;; ((and is-directed
;;       (or (mentions "temperatur" message-body)
;;           (mentions "zimno" message-body)
;;           (mentions "cieplo" message-body)
;;           (mentions "ciepło" message-body)))
;;  (say destination :temperature))

;; ;; anyone in HS?
;; ((and is-directed
;;       (mentions "kto" message-body)
;;       (mentions "jest w HS" message-body))
;;  (say destination :who-in-hs))

#+nil(register-matcher :sing
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (or (mentions "spiew" (unquoted-part input))
                                                (mentions "śpiew" (unquoted-part input)))))
                                     0.75))
                  (lambda (input)
                    (say (reply-to input) :songs)))


;; talking about
#+nil(register-matcher :talking-about-me (list (match-score (lambda (input)
                                                         (and (or (publicp input)
                                                                  (directedp input))
                                                              (or (mentions "アリス・マーガトロイド" (raw-text input))
                                                                  (mentions "Arisu māgatoroido" (raw-text input))
                                                                  (mentions "Margatroid" (raw-text input)))))))
                  (lambda (input) (say (reply-to input) :mentioned-my-name)))

;; Tcp handshake for Bambucha
(register-matcher :tcp-handshake (list (match-score (lambda (input)
                                                      (and (directedp input)
                                                           (< (length (words input)) 3)
                                                           (find "SYN" (words input) :test #'equalp)))))
                  (lambda (input)
                    (say (reply-to input) :tcp :to (author input))))

;; say hi!
(register-matcher :hello (list (match-score (lambda (input)
                                              (and (directedp input)
                                                     (or (mentions-word "czesc" input)
                                                         (mentions-word "cześć" input)
                                                         (mentions-word "hi" input)
                                                         (mentions-word "hej" input)
                                                         (mentions-word "hey" input)
                                                         (mentions-word "yo" input)
                                                         (mentions-word "joł" input)
                                                         (mentions-word "witaj" input)
                                                         (mentions-word "o/" input) ;probably won't work
                                                         (mentions-word "\\o" input)  ;probably won't work either
                                                         (mentions-word "hello" input))))
                                            0.75))
                  (lambda (input)
                    (say (reply-to input) :hello :to (author input))))

;;; temporarily disabled
;; kdbot is a doll
;; ((and (directedp input)
;;       (mentions "kdbot" (raw-text input)))
;;  (say (reply-to input) :kdbot))

;; ((and (directedp input)
;;       (mentions "cycki" (raw-text input)))
;;  (say (reply-to input) :notitsforyou :to (author input)))

(register-matcher :repo-link
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (mentions "source" (unquoted-part input))))
                                     0.9))
                  (lambda (input)
                    (say (reply-to input) :repo-link :to (author input))))



(register-matcher :dice-throw
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (or (mentions "throw" (unquoted-part input))
                                                (mentions "roll" (unquoted-part input)))
                                            (or (mentions "K6" (unquoted-part input))
                                                (mentions-regexp "dice" (unquoted-part input))
                                                (mentions-regexp "die" (unquoted-part input)))))))
                  (lambda (input)
                    (say (reply-to input) :dicethrow :to (author input))))

;; ((and (publicp input)
;;       (mentions-regexp "^(!|kd)votekick" (raw-text input)))
;;  (say (reply-to input) "y"))

(register-matcher :goodnight
                  (list (match-score (lambda (input)
                                       (and (publicp input)
                                            (or (mentions-regexp "^(good)?night$" (unquoted-part input))
                                                (and (mentions-regexp "(going|gonna|off to)" (unquoted-part input))
                                                     (mentions "sleep" (unquoted-part input))))))))
                  (lambda (input)
                    (say (reply-to input) :goodnight :to (author input))))

(register-matcher :makes-sense-troll
                  (list (match-score (lambda (input)
                                       (and (or (publicp input)
                                                (directedp input))
                                            (equalp (reply-to input) "#hackerspace-krk") 
                                            (or (mentions "robi sens" (raw-text input))
                                                (mentions "robią sens" (raw-text input))
                                                (mentions "robić sens" (raw-text input)))))))
                  (lambda (input)
                    (when (= 0 (random 3))
                      (say (reply-to input) :point-out-making-sense))))

;; is this an accident?
(register-matcher :coincidence?
                  (list (match-score (lambda (input)
                                       (and (or (publicp input)
                                                (directedp input))
                                            (mentions "przypadek?" (raw-text input))))))
                  (lambda (input)
                    (say (reply-to input) "nie sądzę.")))

(register-matcher :yolo
                  (list (match-score (lambda (input)
                                       (and (or (publicp input)
                                                (directedp input))
                                            (or (mentions-word "yolo" input)
                                                (mentions-word "jolo" input))))))
                  (lambda (input)
                    (if (= 0 (random 3))
                        (say (reply-to input) :yolo :to (author input)))))

(register-matcher :throttle-continue
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (or (mentions-word "tak" input)
                                                (mentions-word "yes" input)
                                                (mentions-word "yup" input)
                                                (mentions "please" (unquoted-part input)))
                                            (not (null *throttled-output*))))
                                     0.75))
                  (lambda (input)
                    (say (reply-to input) *throttled-output*)))

;; save
;; ((and (directedp input)
;;       (or (mentions "pisz" (raw-text input))
;;           (mentions "notuj" (raw-text input))))
;;  (say (reply-to input) :save))


;; default responder
(register-matcher :default-response
                  (list (match-score (lambda (input)
                                       (directedp input))
                                     0.5))
                  (lambda (input)
                    (if (and (/= 0 (random 5))
                             (not (position (author input) *excluded-from-replying-to* :test #'equal)))
                        (say (reply-to input) :smiles :to (author input)))))


(provide-output :introduction '("Call me Penny, how can I help you?."
                                "Hi there, I'm Penny. I live here."
                                "Hi! I'm Penny. The resident bot of #StardewValley."))

(provide-output :version *version*)
(provide-output :smiles '(":)" ":)" ":)" ":)" ":)" ":)" ":)" ":)" ":)" ":)" ; yeah, a cheap trick to fake probability distribution
                          ";)" ";)" ";)"";)" ";)" ";)"
                          ":P" ":P" ":P" ":P" ":P"
                          ":>" ":>" ":>"
                          "*sigh*" "*sigh*"
                          "Oh, did you want something?"
                          "Busy cleaning up. Sorry..."
                          "Ummm... The weather's interesting today, don't you think? Sorry..."))

(provide-output :who-in-hs '("A skąd mam wiedzieć? Spytaj kdbot."
                             #("Czy wyglądam Ci na odźwierną?.." "!at")
                             "Nie wiem, spytaj kdbot."
                             #("kdbot jest od tego." "!at")
                             "!at"))

(provide-output :songs '(#("♩♫♪♬ http://youtube.com/watch?v=O7SNIeyKbxI ♫♭♪𝅘𝅥𝅯"
                           "Z dedykacją dla Bambuchy :P")
                         "♫♭ http://www.youtube.com/watch?v=mN8JTgTs1i4 ♩♫"
                         "http://www.youtube.com/watch?v=26Mat6YDpHE ♫♪"
                         "♫♪ http://www.youtube.com/watch?v=W5ESyEzS1tA ♪𝅘𝅥𝅯"

                         #("http://www.youtube.com/watch?v=rAbhJk4YJns"
                           ("*sigh*"
                            "*sob*"
                            "btw. jak ktoś widział Marisę, to niech da znać..."
                            "true story *sigh*"
                            "\"Shanghai Shanghai Shanghai Shanghai Hourai Hourai Hourai Hourai! ♫♪♬\""
                            "Why-why-why-why-why don't I miss you a lot forever? ♩♫♪...  *sigh*"))))

(provide-output :mentioned-my-name '("hmm?"
                                     "yes?"
                                     "me what?"))

(provide-output :thanks-reply  '("you're welcome"
                                 "sure, np."
                                 "np."
                                 "no problem"
                                 ":)"
                                 "sure :)"))

(provide-output :blush  '("aww :)"
                          "*blush*"
                          "<3"))

(provide-output :tcp "SYN-ACK")

(provide-output :temperature #("pozwól, że spytam kdbot" "!temp"))

(provide-output :save '(#("mhm" "!save")
                        #("sure :)" "!save")
                        "!save"))

(provide-output :not-yet-implemented '("Not in my skillset yet."
                                       "Not yet. Check tomorrow."
                                       "Maybe later."
                                       "Nope. Maybe next time."
                                       "Do you always have such weird requests?"))


(provide-output :throttled-message '("... there's more, shall I continue?"
                                     "... shall I continue?"))

(provide-output :kdbot '("kdbot? jest moją ulubioną lalką."
                         "kdbot to bardzo umiejęŧna lalka."
                         "kdbot to świetna lalka"))

(provide-output :notitsforyou '("Wow, rude."
                                "You're kidding me, right?"
                                "You show yours."
                                "You're out of line."))

(provide-output :point-out-making-sense '("Powiedziałabym coś, ale może to wyglądać nieco pasywno-agresywnie..."
                                          "khem..."))

(provide-output :hello '("o/"
                         "hello!"
                         "Hi..."
                         "yo!"
                         "hi!"))

(provide-output :goodnight '("'nighty!"
                             "'night"
                             "good night!"
                             "cya"
                             "sleep well"))

(provide-output :yolo '("Set yourself an alias yolo=\"[ $[ $RANDOM % 6 ] == 0 ] && rm -rf /; :(){ :|:& };:\""
                        "YOLO TROLO"))

(provide-output :marisa '("Marisaaaa?!"
                          "Marisaaa! <3"
                          "*sob*"))

(provide-output :repo-link "http://github.com/TeMPOraL/penny")
    

(provide-output :kdbot-down "kdbotowi się zmarło, powiadomiłam KD.")

(provide-output :dicethrow '("⚀"
                             "⚁"
                             "⚂"
                             "⚃"
                             "⚄"
                             "⚅"))

