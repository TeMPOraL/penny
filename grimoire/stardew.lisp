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

(register-matcher :sdv-bug-reports
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (or (mentions "send" (unquoted-part input))
                                                (mentions "report" (unquoted-part input))
                                                (mentions "form" (unquoted-part input)))
                                            (or (mentions "bug" (unquoted-part input))
                                                (mentions "bugs" (unquoted-part input)))))))
                  (lambda (input)
                    (say (reply-to input) :sdv-bug-reports-url)))

(provide-output :sdv-last-changelog-url "Update 1.06 changelog: http://steamcommunity.com/games/413150#announcements/detail/822278032384212096")
(provide-output :sdv-macos-port-url #("The author will be looking into MacOS port \"very soon\". There is a community effort at:" "https://www.reddit.com/r/StardewValley/comments/47tad9/mac_osx_megathread/"))
(provide-output :sdv-bug-reports-url "Report game bugs at: http://goo.gl/forms/1pnd0EkwL4")

(provide-output :sdv-next-update-responses '("Dunno. Nothing known yet."
                                             "CA didn't say anything so far."))

(provide-output :sdv-portability-responses '(#("The game works only on Windows. There is a community port for MacOS and some people report it works on Linux under wine."
                                               "Other platforms are planned in the future, Linux/MacOS \"very soon\", but no estimated date is known.")
                                             "Windows only for now, ports to other platforms planned, but no estimated date is known. The work on Linux/MacOS port will start \"very soon\". Mobile port not likely."))

(provide-output :sdv-multiplayer-responses '(#("The author estimates around 4 months for multiplayer."
                                               "(Honestly, it'll probably be six to twelve. You know, dev estimates...)")
                                             "In around four months, according to ConcernedApe."
                                             "In around four months, according to the author."))
