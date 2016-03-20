(in-package #:alice)

(register-matcher :sdv-changelog
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (or (mentions "changelog" (unquoted-part input))
                                                (mentions "patch notes" (unquoted-part input))
                                                (mentions "last patch" (unquoted-part input))
                                                (mentions "update notes" (unquoted-part input))
                                                (mentions "last update" (unquoted-part input)))))))
                  (lambda (input)
                    (say (reply-to input) :sdv-last-changelog-url)))

(register-matcher :sdv-next-update
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (or (mentions "future" (unquoted-part input))
                                                (mentions "next" (unquoted-part input))
                                                (mentions "upcoming" (unquoted-part input)))
                                            (or (mentions "update" (unquoted-part input))
                                                (mentions "patch" (unquoted-part input))
                                                (mentions "release" (unquoted-part input)))))))
                  (lambda (input)
                    (say (reply-to input) :sdv-next-update-responses)))

(register-matcher :sdv-portability
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (or (mentions "port" (unquoted-part input))
                                                (mentions "linux version" (unquoted-part input)))))))
                  (lambda (input)
                    (say (reply-to input) :sdv-portability-responses)))

(register-matcher :sdv-portability-macos
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (or (mentions "macos" (unquoted-part input)))))
                                     1.25))
                  (lambda (input)
                    (say (reply-to input) :sdv-macos-port-url)))

(register-matcher :sdv-multiplayer
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (or (mentions "multi" (unquoted-part input))
                                                (mentions "multiplayer" (unquoted-part input))
                                                (mentions "coop" (unquoted-part input)))))))
                  (lambda (input)
                    (say (reply-to input) :sdv-multiplayer-responses)))

(provide-output :sdv-last-changelog-url "Update 1.06 changelog: http://steamcommunity.com/games/413150#announcements/detail/822278032384212096")
(provide-output :sdv-macos-port-url "https://www.reddit.com/r/StardewValley/comments/47tad9/mac_osx_megathread/")

(provide-output :sdv-next-update-responses '("Dunno. Nothing known yet."
                                             "CA didn't say anything so far. Wait for his AMA."))

(provide-output :sdv-portability-responses '(#("The game works only on Windows. There is a community port for MacOS and some people report it works on Linux under wine."
                                               "Other platforms are planned in the future, *after* content updates, but no estimated date is known. I.e. probably not soon.")
                                             "Windows only for now, ports to other platforms planned, but no estimated date is known."))

(provide-output :sdv-multiplayer-responses '(#("The author estimates around 4 months for multiplayer."
                                               "(Honestly, it'll probably be six to twelve. You know, dev estimates...)")
                                             "In around four months, according to ConcernedApe."
                                             "In around four months, according to the author."))
