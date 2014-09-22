(ns clojure-protobuf-demo.core
  (:require [clojure.java.io :as io])
  (:gen-class :main true))


(use 'flatland.protobuf.core)
(import com.example.Example$Person)

(defn demo
  "demo clojure protobuf"
  [x]
  (println x "Hello, World from clojure protobuf demo!")

  (def Person (protodef Example$Person))

  (def p (protobuf Person :id 4 :name "Bob" :email "bob@example.com"))
  ;; => {:id 4, :name "Bob", :email "bob@example.com"}

  (println (assoc p :name "Bill"))
  ;;  => {:id 4, :name "Bill", :email "bob@example.com"}

  (println (assoc p :likes ["climbing" "running" "jumping"]))
  ;; => {:id 4, name "Bob", :email "bob@example.com", :likes ["climbing" "running" "jumping"]}

  (println (def b (protobuf-dump p)))
  ;; => #<byte[] [B@7cbe41ec>

  (protobuf-load Person b)
  ;; {:id 4, :name "Bob", :email "bob@example.com"}

)

(defn -main
  "The application's main function"
  [& args]
  (println "-main for clojure-protobuf-demo.core is running")
  (println args)
  (clojure-protobuf-demo.core/demo 1)
  )

