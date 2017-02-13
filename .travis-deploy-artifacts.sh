#!/bin/bash

echo "Publishing..."

# Do not deploy archives when building pull request
if [ "$TRAVIS_BRANCH" != "master" ] || [ "$TRAVIS_PULL_REQUEST" == "true" ]; then
  exit 0
fi

# Decrypt secring.gpg

openssl aes-256-cbc -K $encrypted_d349fd801c84_key -iv $encrypted_d349fd801c84_iv -in secring.gpg.enc -out secring.gpg -d

# Deploy jar artifacts to Sonatype OSSRH

echo "Publishing archives..."

./gradlew -Psigning.keyId="$SIGNING_KEY" -Psigning.password="$SIGNING_PASSWORD" -Psigning.secretKeyRingFile="${TRAVIS_BUILD_DIR}/secring.gpg" uploadArchives

# Deploy api and reference documentation to gh-pages

echo "Publishing Documentation..."

HAWAII_FRAMEWORK_VERSION=`cat gradle.properties | grep "version" | cut -d'=' -f2`
GH_PAGES_DIR=.gh-pages
GH_REF=github.com/hawaiifw/hawaii-framework

rm -rf $GH_PAGES_DIR
git clone --quiet --branch=gh-pages https://${GH_TOKEN}@${GH_REF} $GH_PAGES_DIR > /dev/null 2>&1

rm -rf $GH_PAGES_DIR/docs/$HAWAII_FRAMEWORK_VERSION
mkdir -p $GH_PAGES_DIR/docs/$HAWAII_FRAMEWORK_VERSION
unzip -o build/distributions/hawaii-framework-${HAWAII_FRAMEWORK_VERSION}-docs.zip -d $GH_PAGES_DIR/docs/$HAWAII_FRAMEWORK_VERSION

git -C $GH_PAGES_DIR config user.email "travis@travis-ci.org"
git -C $GH_PAGES_DIR config user.name "Travis"
git -C $GH_PAGES_DIR add --all
git -C $GH_PAGES_DIR commit --allow-empty -m "Travis build $TRAVIS_BUILD_NUMBER pushed docs to gh-pages"
git -C $GH_PAGES_DIR push origin gh-pages > /dev/null 2>&1

rm -rf $GH_PAGES_DIR
