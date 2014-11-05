;; http://z.caudate.me/give-your-clojure-workflow-more-flow/
{:user
 {:plugins [[lein-pprint "1.1.1"]
            [lein-midje "3.1.3"]
            [jonase/eastwood "0.1.4"]
            [cider/cider-nrepl "0.8.0-SNAPSHOT"]
            [lein-ancient "0.4.3"]]
  :dependencies [[spyscope "0.1.4"]
                 [org.clojure/tools.namespace "0.2.4"]
                 [leiningen #=(leiningen.core.main/leiningen-version)]
                 ;; [im.chit/vinyasa "0.2.0"]
                 [io.aviso/pretty "0.1.12"]]
  :injections [(require 'spyscope.core
                        ;; '[vinyasa.inject :as inj]
                        'io.aviso.repl
                        'clojure.repl
                        'clojure.main)
               ;; (inj/inject 'clojure.core
               ;;             '[[vinyasa.inject inject]
               ;;               [vinyasa.pull pull]
               ;;               [vinyasa.lein lein]
               ;;               [vinyasa.reimport reimport]
               ;;               [clojure.repl apropos dir doc find-doc source [root-cause cause]]
               ;;               [clojure.tools.namespace.repl [refresh refresh]]
               ;;               [clojure.pprint [pprint >pprint]]
               ;;               [io.aviso.binary [write-binary >bin]]])
               (alter-var-root #'clojure.main/repl-caught (constantly @#'io.aviso.repl/pretty-pst))
               (alter-var-root #'clojure.repl/pst (constantly @#'io.aviso.repl/pretty-pst))]
  }
 :repl-options {
    :nrepl-middleware [io.aviso.nrepl/pretty-middleware]
 }}
