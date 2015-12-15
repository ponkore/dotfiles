;; http://z.caudate.me/give-your-clojure-workflow-more-flow/
{:user
 {:plugins [[lein-pprint "1.1.2"]
            [cider/cider-nrepl "0.11.0-SNAPSHOT"]
            [lein-ancient "0.6.8" :exclusions [org.clojure/clojure]]]
  :dependencies [[clj-time "0.11.0"]
                 [spyscope "0.1.5" :exclusions [clj-time]]
                 [org.clojure/tools.namespace "0.2.10"]
                 [org.clojure/tools.nrepl "0.2.12"]
                 [leiningen #=(leiningen.core.main/leiningen-version)]
                 [im.chit/hara "2.2.11"]
                 [im.chit/vinyasa "0.4.2" :exclusions [im.chit/hara.namespace.import]]]
  :injections [(require 'spyscope.core)
               (require '[vinyasa.inject :as inject])
               (inject/in  ;; the default injected namespace is `.`
                ;; note that `:refer, :all and :exclude can be used
                [vinyasa.inject :refer [inject [in inject-in]]]
                [vinyasa.lein :exclude [*project*]]
                ;; same as [cemerick.pomegranate :refer [add-classpath get-classpath resources]]
                [cemerick.pomegranate add-classpath get-classpath resources]
                ;; inject into clojure.core
                clojure.core
                [vinyasa.reflection .> .? .* .% .%> .& .>ns .>var]
                [vinyasa.lein lein]
                ;; inject into clojure.core with prefix
                clojure.core >
                [clojure.pprint pprint]
                [clojure.java.shell sh]
                [clojure.tools.namespace.repl refresh]
                [clojure.repl apropos dir doc find-doc source [root-cause cause]])]
  }
 }
