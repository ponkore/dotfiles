;; http://z.caudate.me/give-your-clojure-workflow-more-flow/
{:user
 {:plugins [[lein-pprint "1.1.1"]
            [lein-midje "3.1.3"]
            [jonase/eastwood "0.1.4"]
            [cider/cider-nrepl "0.9.0-SNAPSHOT"]
            [lein-ancient "0.6.2"]
            ]
  :dependencies [[spyscope "0.1.5"]
                 [org.clojure/tools.namespace "0.2.7"]
                 [org.clojure/tools.nrepl "0.2.7"]
                 [leiningen #=(leiningen.core.main/leiningen-version)]
                 [im.chit/iroh "0.1.11"]
                 [io.aviso/pretty "0.1.8"]
                 [im.chit/vinyasa "0.3.4"]]
  :injections [(require 'spyscope.core)
               (require '[vinyasa.inject :as inject])
               (require 'io.aviso.repl)
               (inject/in  ;; the default injected namespace is `.`

                ;; note that `:refer, :all and :exclude can be used
                [vinyasa.inject :refer [inject [in inject-in]]]
                [vinyasa.lein :exclude [*project*]]

                ;; imports all functions in vinyasa.pull
                [vinyasa.pull :all]

                ;; same as [cemerick.pomegranate
                ;;           :refer [add-classpath get-classpath resources]]
                [cemerick.pomegranate add-classpath get-classpath resources]

                ;; inject into clojure.core
                clojure.core
                [vinyasa.reflection .> .? .* .% .%> .& .>ns .>var]

                ;; inject into clojure.core with prefix
                clojure.core >
                [clojure.pprint pprint]
                [clojure.java.shell sh]
                [clojure.tools.namespace.repl refresh]
                [clojure.repl apropos dir doc find-doc source [root-cause cause]])]
  }
 ;; :repl-options {
 ;;    :nrepl-middleware [io.aviso.nrepl/pretty-middleware]
 ;; }
 }
