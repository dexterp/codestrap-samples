#!/bin/sh
cat <<EOF
{
  "uname": "$(uname)",
  "hostname": "$(hostname)"
}
EOF
