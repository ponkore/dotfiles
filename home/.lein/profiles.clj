{:user
 {:plugins [[lein-pprint "1.1.2"]
            [lein-ancient "0.6.14" :exclusions [org.clojure/clojure]]]}
 :repl
 {:dependencies [[clj-time "0.15.0"]
                 [spyscope "0.1.6" :exclusions [clj-time]]]
  :injections [(require 'spyscope.core)]}}
