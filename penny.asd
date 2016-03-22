;;;; alice.asd

(asdf:defsystem #:penny
  :serial t

  :long-name "Penny - a clone of Alice Margatroid"
  :author "Jacek Złydach"
  :version (:read-file-form "version.lisp" :at (1 2 2))
  :description "IRC bot responding to queries based on natural language.."
  :long-description "Alice cloned to serve a different channel."

  :license "Teaware - do whatever you want with it, but I wouldn't mind getting invited for a cup of tea ;)."
  :homepage "https://github.com/TeMPOraL/penny"
  :bug-tracker "https://github.com/TeMPOraL/penny/issues"
  :source-control (:git "https://github.com/TeMPOraL/penny.git")
  :mailto "temporal.pl+pennysdv@gmail.com"

  :encoding :utf-8
  
  :depends-on (#:closer-mop
               #:cl-irc
               #:alexandria
               #:drakma
               #:cl-unicode
               #:cl-ppcre
               #:cxml
               #:cl-json
               #:local-time
               #:chronicity
               #:trivial-timers
               #:swank
               #:marshal)
  
  :components ((:file "package")
               (:file "version")

               (:module "utils"
                        :components ((:file "debug")
                                     (:file "persistence")
                                     (:file "string")
                                     (:file "macros")))
               
               (:file "language")
               
               (:module "core"
                        :components ((:file "trivial-event-loop")
                                     (:file "channel")
                                     (:file "message")
                                     (:file "person")
                                     (:file "world-model")
                                     (:file "input-matcher")
                                     (:file "output-builder")))

               (:module "grimoire"
                        :components ((:file "email")
                                     (:file "github")
                                     (:file "google")
                                     (:file "frequencies")
                                     (:file "meetups")
                                     (:file "notifications")
                                     (:file "people")
                                     (:file "package-tracking")
                                     (:file "pushover")
                                     (:file "stardew")
                                     (:file "tinyurl")
                                     (:file "varia")
                                     (:file "wolfram-alpha")))

               (:file "main" :depends-on ("grimoire"))

               (:module "specials"
                        :components ((:file "blueline")
                                     (:file "comments")
                                     (:file "general-terms")
                                     (:file "standard-answers")
                                     (:file "starpoints")
                                     (:file "specials")))

               (:file "local-config" :depends-on ("grimoire"))))

