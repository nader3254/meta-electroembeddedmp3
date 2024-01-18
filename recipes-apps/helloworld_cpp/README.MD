# Yocto Project Hello World Recipe

This Yocto Project recipe provides a simple example for building and installing a C++ application called 'helloworld_cpp'. The recipe is derived from the 'Hello World!' example in the Yocto Project Development Manual.

## Recipe Metadata

- **SUMMARY**: bitbake-layers recipe
- **DESCRIPTION**: Recipe example for a CPP application on local
- **LICENSE**: CLOSED
- **SRC_URI**: file://helloworld.cpp

## Compilation and Linking Flags

```bash
TARGET_CC_ARCH += "${LDFLAGS}"

