# Package

version       = "1.0.0"
author        = "kkrriisssshh"
description   = "watch exclusively serial experiments lain from your terminal!"
license       = "GPL-3.0-or-later"
srcDir        = "src"
# binDir        = "build"
bin           = @["lain"]
backend       = "c"


# Dependencies

requires "nim >= 1.6.10"
# requires "illwill >= 0.4.1"
requires "cligen >= 1.7.1"

# Tasks

task compress, "compress the release build":
  exec "upx --overlay=strip --best --lzma " & bin[0]