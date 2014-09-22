(defproject clojure-protobuf-demo "0.1.0-SNAPSHOT"
  :description "A Clojure library demonstrating receiving events over protobuf, the serialization format for Pebblez."
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.6.0"]
                 [org.flatland/protobuf "0.8.1"]
                ]
  :plugins [[lein-protobuf "0.2.0"]
 ]
  :aot [clojure-protobuf-demo.core]
  :main clojure-protobuf-demo.core
  :auto-clean false

 :profiles {:debug {:debug true
                    :injections [(prn (into {} (System/getProperties)))]
                   }
            ;; activated automatically during uberjar
            :uberjar {:aot :all}
 }
)
