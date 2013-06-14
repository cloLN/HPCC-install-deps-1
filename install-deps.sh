#!/bin/bash


. deps-common

cfg.parser "deps.conf"
unset IFS

os=${1:-ubuntu}
ver=${2:-11.10}
dev=${3:-}

deps_line=${os}_$ver

cfg.section.${deps_line}

if [ "$os" == "centos" ];
then
        cmd="yum install -y -q"
elif [ "$os" == "opensuse" ];
then
	cmd="zypper install -y"
else
        cmd="apt-get install -y"
fi

if [ "$pre_file" != "" ];
then
	deps/$pre_file
fi

for i in `cat deps/$file`;
do
        $cmd $i
done

if [ "$add_file" != "" ];
then
	deps/$add_file
fi

deps/cmake.deps
deps/rembed.deps
