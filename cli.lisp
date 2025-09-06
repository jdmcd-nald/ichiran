(defpackage :ichiran/cli
  (:use :cl :ichiran/all)
  (:export :build)
  )

(in-package :ichiran/cli)

(opts:define-opts
  (:name :help
   :description "print this help text"
   :short #\h
   :long "help")
  (:name :eval
   :description "evaluate arbitrary expression and print the result"
   :short #\e
   :long "eval")
  (:name :info
   :description "print dictionary info"
   :short #\i
   :long "with-info")
  (:name :full
   :description "full split info (as JSON)"
   :short #\f
   :long "full")
   (:name :limit
   :description "limit segmentations to the specified number (useful only with -f or --full) [Example: ichiran-cli -f -l 5 \"一覧は最高だぞ\"]"
   :short #\l
   :long "limit"
   :arg-parser #'parse-integer
   :default 1
   :meta-var "LIMIT"))

(defun unknown-option (condition)
  (format t "warning: ~s option is unknown!~%" (opts:option condition))
  (invoke-restart 'opts:skip-option))

(defun print-error (fmt &rest args)
  (apply 'format *error-output* fmt args)
  (finish-output *error-output*))

(defmethod jsown:to-json ((word-info word-info))
  (jsown:to-json (word-info-gloss-json word-info)))

(defun print-romanize-info (info)
  (loop for (word . gloss) in info
        do (format t "~%~%* ~a  ~a" word gloss)))

(defun first-non-char (key)
  (defparameter num 0)
  (defparameter multi-check 0)
  (loop for i from 0 to (- (length key) 1) do
     

     
     (if (and (> num 0) (= multi-check 3))
        (setq num (- num multi-check))
     )
     (if (and (> num 0) (= multi-check 3))
         (setq multi-check 0)
     )
     (if (and (string= (aref key i) "\.") (= num 0) (= multi-check 2))
        (setq multi-check (+ multi-check 1))
     )
     (if (and (string= (aref key i) ">") (= num 0) (= multi-check 1))
        (setq multi-check (+ multi-check 1))
     )
     (if (and (string= (aref key i) "<") (= num 0) (= multi-check 0))
        (setq multi-check (+ multi-check 1))
     )
         
     (if (or (string= (aref key i) " ") (string= (aref key i) #\Newline))
       (if (= num 0)
         (setq num i)
       )
     )
  )

  (* num 1)
)

(defun first-non-char-start (key)
       
  (defparameter num 0)
          
  (defparameter multi-check 0)
           
  (loop for i from 0 to (- (length key) 1) do
     
     
     
     (if (and (> num 0) (= multi-check 3))
         (- num multi-check)
     )
     
     (if (and (string= (aref key i) ".") (= num 0) (= multi-check 3))
         (setq multi-check(+ multi-check 2))
     )
    
     (if (and (string= (aref key i) ">") (= num 0) (= multi-check 1))
                 (setq multi-check(+ multi-check 2))
     )
     
     (if (and (string= (aref key i) "<") (= num 0) (= multi-check 0))
                  (setq multi-check(+ multi-check 1))
     )
     
     
     (if (and (> i multi-check) (or (string= (aref key i) " ") (string= (aref key i) #\Newline)))
       (if (= num 0)
         (setq num i)
       )
     )
  )
  (* multi-check 1)
)

(defun print-input-w-parentheses-2 (input charp charl current-print shortinput)
  
  (loop for i from 0 to (- current-print 1) do
     (princ (aref input i))
  )
  (loop for i from 0 to (- (length shortinput) 1) do
     (if (= i charp) ( princ "\(" ))
     (princ (aref shortinput i))
     (if (= i (- (+ charp charl) 1)) ( princ "\)" ))
     (if (= i (- (+ charp charl) 1)) ( setq  current-print (+ current-print i) ))
  )
  (* current-print 1)
)

(defun print-input-w-parentheses (input charp charl)
  
  (loop for i from 0 to (- (length input) 1) do
     (if (= i charp) ( princ "\(" ))
     (princ (aref input i))
     (if (= i (- (+ charp charl) 1)) ( princ "\)" ))
  )
)

(defun print-romanize-info-w-input (info input r)
  (defparameter charl 0)
  (defparameter charp 0)
  (defparameter charstart 0)
  
  (defparameter shortinput "h")
  (defparameter current-print 0)
  
  (loop for (word . gloss) in info
        do (format t "~%~%~%*")
            
           (setq charl (first-non-char gloss))
           
           (setq charstart  (first-non-char-start gloss))
           
           (setq charp (search (subseq gloss charstart (+ charstart charl)) input))     
           ;;(print-input-w-parentheses input charp charl)                           
           (setq shortinput (subseq input current-print (length input)))
           
           (setq charp (search (subseq gloss charstart (+ charstart charl)) shortinput))
           (setq current-print (print-input-w-parentheses-2 input charp charl current-print shortinput))
           (format t "*~% ~a  ~a" word gloss)
           
           
  )
)

(defun main ()
  (load-connection-from-env)
  (multiple-value-bind (options free-args)
      (handler-case
          (handler-bind ((opts:unknown-option #'unknown-option))
            (opts:get-opts))

        (opts:missing-arg (condition)
          (print-error "fatal: option ~s needs an argument!~%"
                       (opts:option condition))
          (opts:exit 1))
        (opts:arg-parser-failed (condition)
          (print-error "fatal: cannot parse ~s as argument of ~s~%"
                       (opts:raw-arg condition)
                       (opts:option condition))
          (opts:exit 1))
        (opts:missing-required-option (con)
          (print-error "fatal: ~a~%" con)
          (opts:exit 1)))
    (cond
      ((getf options :help)
       (opts:describe
        :prefix "Command line interface for Ichiran"
        :suffix "By default calls ichiran:romanize, other options change this behavior"
        :usage-of "ichiran-cli"
        :args     "[input]"))
      ((getf options :eval)
       (let ((input (car free-args)))
         (use-package :ichiran/all)
         (mapcar 'print (multiple-value-list (eval (read-from-string input))))))
      ((getf options :info)
       (let ((input (join " " free-args)))
         (multiple-value-bind (r info) (romanize input :with-info t)
           (princ r)
           (print-romanize-info-w-input info input r))))
      ((getf options :full)
       (let* ((input (join " " free-args))
              (limit-value (getf options :limit))
              (result (romanize* input :limit limit-value)))
         (princ (jsown:to-json result))))
      (t (let ((input (join " " free-args)))
           (princ (romanize input :with-info t))))
      ))
  (terpri)
  (finish-output))



(defun setup-debugger ()
  (setf *debugger-hook*
        (lambda (condition old-hook)
          (declare (ignore old-hook))
          (print-error "ERROR: ~a" condition)
          (opts:exit 2))))

(defun build (&key conn debug)
  (when conn
    (switch-conn-vars conn))

  (format t "Initializing caches~%")
  (init-all-caches)
  (init-suffixes t)

  ;; remove references to db connections which become obsolete once the image is loaded
  (postmodern:clear-connection-pool)

  (unless debug
    (setup-debugger))

  (asdf:make :ichiran/cli))
