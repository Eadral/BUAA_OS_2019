#!/bin/sh
find dir -name lab0_x > lab0_exam.c
grep "hello OS lab0" -rn dir >> lab0_exam.c
