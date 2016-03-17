#!/bin/bash

CODEGEN=../bin/c_codegen_ref
MIPS_GCC=gcc

(cd .. && make bin/c_codegen)

for i in input/*.c; do
  BASE=$(basename $i .c);

  ###################################
  ## Reference (native) version

  gcc driver.c $i -o build/$BASE.ref
  ./build/$BASE.ref > output/$BASE.ref

  ###################################
  ## Tested (MIPS) version

  # TODO: C pre-processor?
  cat $i | $CODEGEN > build/$BASE.got.s

  ${MIPS_GCC} driver.c build/$BASE.got.s -o build/$BASE.got
  build/$BASE.got > output/$BASE.got

  diff output/$BASE.got output/$BASE.ref > output/$BASE.diff;
  if [[ $? != 0 ]]; then
    echo "$BASE, FAIL, see output/$BASE.diff";
  else
    echo "$BASE, pass";
  fi
done
