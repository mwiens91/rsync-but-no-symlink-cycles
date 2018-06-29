#!/usr/bin/env python
"""Format --exclude flags for rsync by excluding common paths."""

import os.path
import sys

full_exclude_path = sys.argv[1]
source_path = sys.argv[2]

print full_exclude_path[len(os.path.dirname(source_path)):]
