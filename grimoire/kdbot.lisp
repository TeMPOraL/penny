(in-package #:alice)

(defun notify-kdbot-down ()
  #+nil(send-email *kdbot-notification-email* "Hej, kdbot padł :(. Pozdrawiam!"))
