(in-package #:alice)

(defparameter *url-regexp* "((^https?\\:.*)|(www\\..*))")
(defparameter *url-shortening-regexp* "(http.*)")

(register-matcher :shorten-url
                  (list (match-score (lambda (input)
                                       (and (directedp input)
                                            (or (mentions "shorten" (unquoted-part input))
                                                (mentions "shorten" (unquoted-part input)))))))
                  (lambda (input)
                    (say (reply-to input) (shorten-url (parse-message-for-url-shortening (unquoted-part input))))))

(provide-output :nothing-to-shorten  #(("If you won't tell me what, I won't shorten it."
                                        "Shorten what?!"
                                        "*sigh*")
                                       ("pro tip: URLs tend to start with http://"
                                        "If you write me a nice URL that starts http:// then we can talk.")))

(provide-output :failed-in-shortening '("It didn't work... *sigh*"
                                        "http://something.is.broken.sad :/"
                                        "I cannot into shortening links. *sob*"))

(defun shorten-url (url)
  (if url
      (or (ignore-errors (drakma::http-request "http://tinyurl.com/api-create.php"
                                               :external-format-out :UTF-8
                                               :parameters `(("url" . ,url))))
          :failed-in-shortening)
      :nothing-to-shorten))

(defun extract-urls-from-message (message-body)
  (remove nil (mapcar (lambda (str)(cl-ppcre::scan-to-strings *url-regexp* str))
                      (split-sequence:split-sequence #\Space message-body))))

(defun parse-message-for-url-shortening (text)
  (cl-ppcre:scan-to-strings *url-shortening-regexp* text))
