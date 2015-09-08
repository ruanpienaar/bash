#!/bin/bash
find . -type f | sed -rn 's|.*/[^/]+\.([^/.]+)$|\1|p' | sort -u