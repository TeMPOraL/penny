(in-package #:alice)

(defparameter +starpoint-increment-regex+ "^([^ \\+]+)\\+\\+$")

(defparameter +max-starpoint-scores-list-length+ 10)
(defvar *starpoints-list* '(("Test" . 10) ("Test2" . 20)))

(defparameter *starpoints-title-msg* '("☆Starpoints!"))
(defparameter *starpoints-nice-try-msg* '("Nice try..."
                                          "That's not how it works."
                                          "Can't award starpoints to yourself."
                                          "No."))

(defun starpoint-nick (entry)
  (car entry))

(defun starpoint-score (entry)
  (cdr entry))

(defun (setf starpoint-score) (new-value entry)
  (setf (cdr entry) new-value))

(defun list-starpoints (destination)
  (let* ((points (copy-list *starpoints-list*))
         (sorted (sort points (lambda (lhs rhs) (> (starpoint-score lhs) (starpoint-score rhs)))))
         (split (min +max-starpoint-scores-list-length+ (length sorted))))
    ;; TODO
    (if (> split 0)
        (progn
          (say destination *starpoints-title-msg*)
          (say destination (format nil "~{~A~^, ~}" (mapcar (lambda (entry) (format nil "~A - ☆~A" (starpoint-nick entry) (starpoint-score entry)))
                                                           (subseq sorted 0 split)))))
        (say destination "No starpoints on record."))
    )
  (setf *specials-suppress-normal-output* t))

(defun try-and-match-starpoint-increment (destination message-body from-who)
  (multiple-value-bind (match nick-group) (cl-ppcre:scan-to-strings +starpoint-increment-regex+ message-body)
    (when (and match
               nick-group
               (vectorp nick-group)
               (= 1 (length nick-group)))
      (let* ((nick (elt nick-group 0))
             (score (cdr (assoc nick *starpoints-list* :test #'equalp))))
        (if (equalp nick from-who)
            (say destination *starpoints-nice-try-msg* :to from-who)
            (progn (setf *starpoints-list* (remove-duplicates (acons nick
                                                                     (if score
                                                                         (1+ score)
                                                                         1)
                                                                     *starpoints-list*)
                                                              :test #'equalp
                                                              :key #'car
                                                              :from-end t))
                   (store-starpoints)))))))

(defun handle-starpoints (destination is-private is-public is-directed from-who message-body)
  (cond
        ((and is-directed
              (mentions "starpoints" message-body))
         (list-starpoints destination))

        ((and is-public
              (not is-directed)
              (mentions-regexp +starpoint-increment-regex+ message-body))
         (try-and-match-starpoint-increment destination message-body from-who))))


(defun load-starpoints ()
  (setf *starpoints-list* (dumb-deserialize-list-from-file "starpoints.dat"))) ;FIXME it's not a hash table!

(defun store-starpoints ()
  (dumb-serialize-list-to-file *starpoints-list* "starpoints.dat")) ;FIXME it's not a hash table!
