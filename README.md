# GenomeDISCO



`GenomeDISCO` (**DI**fferences between **S**moothed **CO**ntact maps) is a package for comparing contact maps of 3D genome structures, obtained from experiments such as Hi-C, Capture-C, ChIA-PET, HiChip, etc. It uses random walks on the contact map graph for smoothing before comparing the contact maps, resulting in a concordance score that can be used for quality control of biological replicates.

Read the full paper here: 
*GenomeDISCO: A concordance score for chromosome conformation capture experiments using random walks on contact map graphs.* Oana Ursu, Nathan Boley, Maryna Taranova, Y. X. Rachel Wang, Galip Gurkan Yardimci, William Stafford Noble, Anshul Kundaje. bioRxiv: http://www.biorxiv.org/content/early/2017/08/29/181842

Installation
===

1. Install [Anaconda](https://www.continuum.io/downloads). GenomeDISCO is compatible with Python 2.
2. Obtain and install GenomeDISCO with the following commands:
```
git clone http://github.com/kundajelab/genomedisco
genomedisco/install_scripts/install_genomedisco.sh
```

**Note if you are installing these locally**: There are a few parameters you can provide to the installation script, to point it to your desired python installation, R installation, R library, modules and bedtools installation. Thus, you can run the above script as follows:

```
genomedisco/install_scripts/install_genomedisco.sh --pathtopython /path/to/your/python --pathtor /path/to/your/R --rlib /path/to/your/Rlibrary --modules modulename --pathtobedtools path/to/your/bedtools
```

Quick start
====

Say you want to compare 2 contact maps. For this example, we will use a subset of datasets from Rao et al., 2014. 

First, configure the files used in the example:

```
genomedisco/examples/configure_example.sh
```

Then run the concordance analysis:

```
cd genomedisco
python reproducibility_analysis/3DChromatin_ReplicateQC.py run_all --method GenomeDISCO --metadata_samples examples/metadata.samples --metadata_pairs examples/metadata.pairs --bins examples/Nodes.w40000.bed.gz --outdir examples/output 
```

For detailed explanations of all inputs to GenomeDISCO, see the ["Inputs" section below](#inputs)

To run reproducibility analysis in batches (more than one comparison), all you need to do is modify the `--metadata_samples` and `--metadata_pairs` to add the additional samples and sample pairs respectively that you wish to compare. For details, see ["Analyzing multiple dataset pairs"](#analyzing-multiple-dataset-pairs)

Running other methods for measuring concordance and QC of Hi-C data
====

To run other available methods for computing the reproducibility of Hi-C data, refer to the repository http://github.com/kundajelab/3DChromatin_ReplicateQC and follow the instructions there.

The reproducibility methods supported in 3DChromatin_ReplicateQC are:
- GenomeDISCO (http://github.com/kundajelab/genomedisco)
- HiCRep (http://github.com/qunhualilab/hicrep) 
- HiC-Spector (http://github.com/gersteinlab/HiC-spector) 
- QuASAR-Rep (part of the hifive suite at http://github.com/bxlab/hifive) 

Inputs
=============

Before running GenomeDISCO, make sure to have the following files:

- **contact map** For each of your samples, you need a file containing the counts assigned to each pair of bins in your contact map, and should have the format `chr1 bin1 chr2 bin2 value`. Note: GenomeDISCO assumes that this file contains the contacts for all chromosomes, and will split it into individual files for each chromosome.

- **bins** This file contains the full set of genomic regions associated with your contact maps, in the format `chr start end name` where name is the name of the bin as used in the contact map files above. GenomeDISCO supports both fixed-size bins and variable-sized bins (e.g. obtained by partitioning the genome into restriction fragments). 

GenomeDISCO takes the following inputs:

- `--metadata_samples` Information about the samples being compared. Tab-delimited file, with columns "samplename", "samplefile". Note: each samplename should be unique. Each samplefile listed here should follow the format "chr1 bin1 chr2 bin2 value

- `--metadata_pairs` Each row is a pair of sample names to be compared, in the format "samplename1 samplename2". Important: sample names used here need to correspond to the first column of the --metadata_samples file.

- `--bins` A (gzipped) bed file of the all bins used in the analysis. It should have 4 columns: "chr start end name", where the name of the bin corresponds to the bins used in the contact maps.

- `--re_fragments` Add this flag if the bins are not uniform bins in the genome (e.g. if they are restriction-fragment-based).By default, the code assumes the bins are of uniform length.

- `--methods` Which method to use for measuring concordance or QC. Set this to "GenomeDISCO". For other methods, refer to the repository "http://github.com/kundajelab/3DChromatin_ReplicateQC"

- `--parameters_file` File with parameters for reproducibility and QC analysis. For details see ["Parameters file"](#parameters-file)

- `--outdir` Name of output directory. DEFAULT: replicateQC

- `--running_mode` The mode in which to run the analysis. This allows you to choose whether the analysis will be run as is, or submitted as a job through sge or slurm. Available options are: "NA" (default, no jobs are submitted). Coming soon: "sge", "slurm"

- `--concise_analysis` Set this flag to obtain a concise analysis, which means replicateQC is measured but plots that might be more time/memory consuming are not created. This is useful for quick testing or running large-scale analyses on hundreds of comparisons.

- `--subset_chromosomes` Comma-delimited list of chromosomes for which you want to run the analysis. By default the analysis runs on all chromosomes for which there are data. This is useful for quick testing

Analyzing multiple dataset pairs
======
To analyze multiple pairs of contact maps (or multiple contact maps if just computing QC), all you need to do is add any additional datasets you want to analyze to the `--metadata_samples` file and any additional pairs of datasets you want to compare to the `--metadata_pairs` files. 

Parameters file
======

The parameters file specifies the parameters to be used with GenomeDISCO (and any of the other methods GenomeDISCO supports). The format of the file is: `method_name parameter_name parameter_value`. The default parameters file used by GenomeDISCO is:

```
GenomeDISCO		subsampling	lowest
GenomeDISCO		tmin		3
GenomeDISCO		tmax		3
GenomeDISCO		norm		sqrtvc
HiCRep  h       5
HiCRep  maxdist 5000000
HiC-Spector		n			20
```
Note: all of the above parameters need to be specified in the parameters file.

More questions?
====
Contact Oana Ursu

oursu@stanford.edu



