# pEEFRanking (Enhanced Ensemble Feature Ranking)
pEEFRanking R package is a parallel processing enhancement of EEFRanking for EEFR feature selection algorithm implementation.
This project is part of my Master's Degree on Computer Science and Engineering at [Instituto Superior de Engenharia de Lisboa (ISEL)](https://www.isel.pt/).

The aim of EEFR is to make Feature Ranking and Feature Selection tasks easier for Data Mining (DM) developers in R.
On a DM process, EEFR can be used as feature selection pre-process, before classification.

## Package installation from GitHub:
library("devtools")<br/>
install_github('https://github.com/matpato/EEFR-parallel.git', INSTALL_opts=c("--no-multiarch"))


## Package usage:
library(pEEFRanking)<br/>
features <- ensemble.features.ranking(dataset)<br/>
dataset <- dataset[,c(features, 'class')]

## Package documentation:
The feature selection is executable by ***ensemble.features.ranking(dataset, ...)***. 
A list of optional parameters is available, as specified on the documentation. 
As output, it returns a list with the name of the features sorted in inverse order of relevance. 
The returned list can include all the sorted features or a subset of the first most relevant ones.

pEEFRanking documentation is accessible by: ***help(package="pEEFRanking")***. 
The R package includes a demo example, executable by: ***example("ensemble.features.ranking")***. 
The example uses an artificial dataset included in R package.

Package pEEFRanking is accessible from https://github.com/matpato/EEFR-parallel.git repository <br/>
The original package EEFRanking is accessible from https://github.com/matpato/EEFR.git repository
