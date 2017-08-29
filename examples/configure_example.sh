#!/bin/bash

d=$(pwd)

#make metadata for the examples
metadata_samples=${d}/examples/metadata.samples
printf "HIC001\t${d}/examples/HIC001.res40000.gz\n" > ${metadata_samples}
printf "HIC002\t${d}/examples/HIC002.res40000.gz\n" >> ${metadata_samples}

metadata_pairs=${d}/examples/metadata.pairs
printf "HIC001\tHIC002\n" > ${metadata_pairs}