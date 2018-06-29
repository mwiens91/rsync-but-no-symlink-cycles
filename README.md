# rsync-but-no-symlink-cycles

A rather unelegant way of running rsync over a source directory that
contains symlink cycles.

Run with

```
./rsync_exclude_symlink_cycles.sh [source_directory] [destination_directory]
```

Oh, when I used that `./` in the above snipped I literally meant it:
make sure you run this in the same directory that the above script (and
the helper python script) exists.
