#!/usr/bin/env bash
# Downloads the free PDFs referenced in this guide into the local pdfs/ folders.
# PDFs are not committed to the repo: some are free to download but not licensed for redistribution.
# Usage: bash scripts/download-pdfs.sh   (run from the repo root)
set -euo pipefail
cd "$(dirname "$0")/.."

get() { # get <dest> <url>
  if [ -s "$1" ]; then echo "skip  $1"; return; fi
  mkdir -p "$(dirname "$1")"
  if curl -fsSL --retry 2 -o "$1" "$2" && file "$1" | grep -q PDF; then echo "ok    $1"
  else rm -f "$1"; echo "FAIL  $1  <- $2"; fi
}

R=01-roadmaps/pdfs
for r in data-engineer data-analyst bi-analyst sql python postgresql-dba; do
  get "$R/roadmapsh-$r.pdf" "https://roadmap.sh/pdfs/roadmaps/$r.pdf"
done

P=03-books-papers/pdfs
get $P/book-think-stats-2e.pdf      https://greenteapress.com/thinkstats2/thinkstats2.pdf
get $P/paper-2003-gfs.pdf           "https://static.googleusercontent.com/media/research.google.com/en//archive/gfs-sosp2003.pdf"
get $P/paper-2004-mapreduce.pdf     https://research.google.com/archive/mapreduce-osdi04.pdf
get $P/paper-2006-bigtable.pdf      "https://static.googleusercontent.com/media/research.google.com/en//archive/bigtable-osdi06.pdf"
get $P/paper-2007-dynamo.pdf        https://www.allthingsdistributed.com/files/amazon-dynamo-sosp2007.pdf
get $P/paper-2010-dremel.pdf        "https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/36632.pdf"
get $P/paper-2011-kafka.pdf         https://www.microsoft.com/en-us/research/wp-content/uploads/2017/09/Kafka.pdf
get $P/paper-2012-spark-rdd.pdf     https://www.usenix.org/system/files/conference/nsdi12/nsdi12-final138.pdf
get $P/paper-2012-spanner.pdf       https://www.usenix.org/system/files/conference/osdi12/osdi12-final-16.pdf
get $P/paper-2016-snowflake.pdf     https://info.snowflake.net/rs/252-RFO-227/images/Snowflake_SIGMOD.pdf
get $P/paper-2020-delta-lake.pdf    https://www.vldb.org/pvldb/vol13/p3411-armbrust.pdf
get $P/paper-2021-lakehouse-cidr.pdf https://www.cidrdb.org/cidr2021/papers/cidr2021_paper17.pdf

echo
echo "Download these two free books manually (the authors serve them through their own pages):"
echo "  OpenIntro Statistics 4e:  https://www.openintro.org/book/os/   -> $P/book-openintro-statistics-4e.pdf"
echo "  ISLP (Statistical Learning with Python): https://www.statlearning.com/  -> $P/book-islp-intro-statistical-learning-python.pdf"
