#!/bin/sh

if [ $# -ne 1 ]; then
    echo usage: $0 "[projectname]"
    exit 1
fi

project_name=$1

author="Masao KATO"
version="1.0"
release="1.0"
language="ja"

basedir=$(pwd)
projectdir="${basedir}/${project_name}"
sphinxdir="${projectdir}/sphinx"

mkdir -p ${projectdir}
cd ${projectdir}

python3 -m venv "sphinx"
cd ${sphinxdir}

. ./bin/activate

pip3 install --upgrade pip
pip3 install -U \
     sphinx \
     sphinx-rtd-theme \
     sphinxcontrib-blockdiag \
     sphinxcontrib-seqdiag \
     sphinxcontrib-plantuml \
     sphinx-autobuild \
     ablog

cd ${projectdir}

sphinx-quickstart \
    --sep \
    --project=${project_name} \
    --author="${author}" \
    -v ${version} \
    --release=${release} \
    --language=${language} \
    --ext-todo \
    --makefile \
    --batchfile \
    ${project_name}

echo "sphinx"                 >> ${projectdir}/.gitignore
echo "${project_name}/build"  >> ${projectdir}/.gitignore

### TODO
## edit conf.py

### edit Makefile
cat >> ${projectdir}/${project_name}/Makefile <<MAKE_PATCH

# sphinx-autobuild
livehtml:
	sphinx-autobuild \$(SPHINXOPTS) "\$(SOURCEDIR)" "\$(BUILDDIR)/html"

MAKE_PATCH
###

### generate conf.py patch
cat > ${projectdir}/${project_name}/source/conf.py.patch <<CONF_PY_PATCH
diff --git a/conf.py b/conf.py
index 97d7b2d..e579a29 100644
--- a/conf.py
+++ b/conf.py
@@ -35,8 +35,14 @@ release = '1.0'
 # ones.
 extensions = [
     'sphinx.ext.todo',
+    'sphinx_rtd_theme',
+    'sphinxcontrib.blockdiag',
+    'sphinxcontrib.seqdiag',
+    'sphinxcontrib.plantuml',
 ]
 
+plantuml = ['java', '-jar', 'plantuml.jar']
+
 # Add any paths that contain templates here, relative to this directory.
 templates_path = ['_templates']
 
@@ -58,7 +64,7 @@ exclude_patterns = []
 # The theme to use for HTML and HTML Help pages.  See the documentation for
 # a list of builtin themes.
 #
-html_theme = 'alabaster'
+html_theme = 'sphinx_rtd_theme'
 
 # Add any paths that contain custom static files (such as style sheets) here,
 # relative to this directory. They are copied after the builtin static files,

CONF_PY_PATCH
###
cd ${projectdir}/${project_name}/source
patch -p1 < conf.py.patch
rm conf.py.patch

cd ${projectdir}

git init .
git add .
git commit -m 'initial commit'
