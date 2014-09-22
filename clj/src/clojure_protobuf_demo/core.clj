(ns clojure-protobuf-demo.core)

(use 'flatland.protobuf.core)
(import com.example.Example$Person)

(defn demo
  "demo clojure protobuf"
  [x]
  (println x "Hello, World from clojure protobuf demo!")

  (def Person (protodef Example$Person))

  (def p (protobuf Person :id 4 :name "Bob" :email "bob@example.com"))
  ;; => {:id 4, :name "Bob", :email "bob@example.com"}

  (print (assoc p :name "Bill"))
  ;;  => {:id 4, :name "Bill", :email "bob@example.com"}

  (print (assoc p :likes ["climbing" "running" "jumping"]))
  ;; => {:id 4, name "Bob", :email "bob@example.com", :likes ["climbing" "running" "jumping"]}

  (print (def b (protobuf-dump p)))
  ;; => #<byte[] [B@7cbe41ec>

  (protobuf-load Person b)
  ;; {:id 4, :name "Bob", :email "bob@example.com"}

)
