#!/bin/sh
# Check if xxhsum is installed
! hash xxhsum 2> /dev/null
_XXH_PRESENT=$?
for i in "$@"; do
	i=$(basename "$i")
	sha1sum "$i" > "$i".sha1
	if [ $_XXH_PRESENT -eq 1 ]; then
		xxhsum -q "$i" > "$i".xxh
	fi
done
