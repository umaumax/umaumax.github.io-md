#!/usr/bin/env bash
cd $(dirname $0)
cd public
gitbook --lrport 35730 --port 4001 serve
