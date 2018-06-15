# Package

version       = "0.1.0"
author        = "emekoi"
description   = "a lispy thingy"
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
bin           = @["lispy"]

# Dependencies

requires "nim   >= 0.18.0"
requires "https://github.com/emekoi/mofunoise >= 0.5.0"
