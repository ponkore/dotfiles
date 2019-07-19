{:user
 {:plugins [[lein-pprint "1.1.2"]
            [lein-ancient "0.6.14" :exclusions [org.clojure/clojure]]]}
 :repl
 {:dependencies [[clj-time "0.15.0"]
                 [org.clojure/core.rrb-vector "0.0.14"]
                 [fipp "0.6.18" :exclusions [org.clojure/clojure org.clojure/core.rrb-vector]]
                 [spyscope "0.1.6" :exclusions [clj-time org.clojure/core.rrb-vector]]]
  :injections [(require 'spyscope.core)]
 :signing {:gpg-key "F1933B1EEFAD412D"}}}
