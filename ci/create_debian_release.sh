#!/bin/bash -xe

if [ $# -ne 1 ] && [ -z "${1}" ]; then
    echo "no version number specified"
    echo "${0} x.y.z"
    exit 1
fi

NEW_VERSION="${1}"
echo "Create release: ${NEW_VERSION}"

export GIT_AUTHOR_NAME="Wolfgang Gehrhardt"
export GIT_COMMITTER_NAME="${GIT_AUTHOR_NAME}"
export DEBNAME="${GIT_AUTHOR_NAME}"

export EMAIL=${EMAIL-"wolfgang.gehrhardt@emlix.com"}
export GIT_AUTHOR_EMAIL="${EMAIL}"
export GIT_COMMITTER_EMAIL="${EMAIL}"
export DEBMAIL="${EMAIL}"

echo "   1.b setup ${EMAIL} /  ${DEBNAME} & ${DEBEMAIL}"

gbp import-ref -u "${NEW_VERSION}" --debian-branch "$(git branch --show-current)"

cp debian/changelog debian.native/
cp debian/gbp.conf debian.native/
git rm -rf debian/
cp -arv debian.native debian
rm debian/README.md
echo "3.0 (quilt)" > debian/source/format

dch -M "--newversion=${NEW_VERSION}-1" "New upstream tag ${NEW_VERSION}"
git add debian/ && git commit -m "New upstream tag ${NEW_VERSION}"

git checkout debian.native/changelog 
rm debian.native/gbp.conf
sudo gbp buildpackage --git-ignore-branch --git-compression=xz
