;; http://z.caudate.me/give-your-clojure-workflow-more-flow/
{:user
 {:plugins [[lein-pprint "1.1.2"]
            [lein-ancient "0.6.14" :exclusions [org.clojure/clojure]]]}
 :repl
 {:dependencies [[clj-time "0.11.0"]
                 [spyscope "0.1.5" :exclusions [clj-time]]
                 [org.clojure/tools.namespace "0.2.10"]
                 [org.clojure/tools.nrepl "0.2.12"]
                 [im.chit/lucid.mind "1.3.13"]
                 [im.chit/lucid.core.inject "1.3.13"]]
  :injections [(require 'spyscope.core)
               (require '[lucid.core.inject :as inject])
               (inject/in ;; the default injected namespace is `.`
                ;; note that `:refer, :all and :exclude can be used
                [lucid.core.inject :refer [inject [in inject-in]]]
                ;; inject into clojure.core
                clojure.core
                [lucid.mind .> .? .* .% .%> .& .>ns .>var]
                ;; inject into clojure.core with prefix
                clojure.core >
                [clojure.pprint pprint]
                [clojure.java.shell sh]
                [clojure.tools.namespace.repl refresh]
                [clojure.repl apropos dir doc find-doc source [root-cause cause]])]
  }}
