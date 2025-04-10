#!/bin/bash -xe

OUTDIR=/base/debianbuild

if [ $# -ne 1 ] && [ -z "${1}" ]; then
    echo "no version number specified"
    echo "${0} x.y.z"
    exit 1
fi

NEW_VERSION="${1}"
echo "Create release: ${NEW_VERSION}"

GLOBMAIL=$(git config --global user.email || true)
GLOBNAME=$(git config --global user.name || true)

LOCMAIL=$(git config --local user.email || true)
LOCNAME=$(git config --local user.name || true)

TMPNAME="${GIT_AUTHOR_NAME:-${LOCNAME:-${GLOBNAME:-}}}"

if [ -z "${TMPNAME}" ]; then
    echo "Invalid environment. Could not determine author name for git"
    exit 1
fi

TMPMAIL="${GIT_AUTHOR_EMAIL:-${LOCMAIL:-${GLOBMAIL:-}}}"

if [ -z "${TMPMAIL}" ]; then
    echo "Invalid environment. Could not determine author e-mail for git"
    exit 1
fi

export GIT_AUTHOR_EMAIL="${TMPMAIL}"
export GIT_COMMITTER_EMAIL="${TMPMAIL}"
export EMAIL="${TMPMAIL}"
export GIT_AUTHOR_NAME="${TMPNAME}"
export GIT_COMMITTER_NAME="${TMPNAME}"
export NAME="${TMPNAME}"

export DEBNAME="${NAME}"
export DEBMAIL="${EMAIL}"

gbp import-ref -u "${NEW_VERSION}" --debian-branch "$(git branch --show-current)"

cp debian/changelog debian.native/
cp debian/gbp.conf debian.native/
git rm -rf debian/
cp -arv debian.native debian
rm debian/README.md
echo "3.0 (quilt)" > debian/source/format

dch -M "--newversion=${NEW_VERSION}-1" "New upstream tag ${NEW_VERSION}"
git add debian/ && git commit -m "New upstream tag ${NEW_VERSION}"
git checkout HEAD -- debian.native && git clean -fxd -- debian.native

gbp buildpackage --git-ignore-branch --git-compression=xz --git-ignore-new -uc -us --git-export-dir="${OUTDIR}" --git-ignore-branch
