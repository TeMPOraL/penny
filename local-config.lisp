(in-package #:alice)

;; basic configuration
(setf *pushover-token* "insert token"
      *pushover-admin-user* "insert pushover user / group key for admin (for emergency / debug notifications)"

      *wolfram-app-id* "insert app id"

      *mailgun-domain* "insert mailgun domain"
      *mailgun-key* "insert mailgun key"

      *github-token* "insert github token here"

      *gdziepaczka-token* "insert gdziepaczka.pl token here"

      *kdbot-notification-email* "insert notification e-mail here"

      *server* "irc.freenode.net"
      *nick* "PennySDV"
      *password* "insert password here"
      *autojoin-channels* '("#TRC")

      *excluded-from-replying-to* '("kdbot" "Repoto|hskrk" "ood" "Magda_M" "Alice_M" "repost"))


;; alternative notifications to memos - specify nick and alternative notification function
(setf (gethash "ShanghaiDoll" *user-notification-medium*) (make-pushover-notifier "insert pushover user or group key")
      (gethash "HouraiDoll" *user-notification-medium*) (make-email-notifier "insert e-mail address"))
