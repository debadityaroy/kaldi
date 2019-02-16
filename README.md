This repository accompanies the paper titled [Unsupervised Action Recognition using Universal Attribute Modelling] https://ieeexplore.ieee.org/document/8576541 and [Action Recognition based on discriminative embedding of actions using Siamese networks] https://ieeexplore.ieee.org/document/845122, for generating action-vectors.

Using this repository, one can reproduce the results on the HMDB51 dataset for Histogram of Optical Flow (HOF) features. These HOF features are extracted using [Improved Dense Trajectory framework] https://lear.inrialpes.fr/people/wang/improved_trajectories.

We provide the extracted HOF features for the HMDB51 dataset [here] 

In order to run the code, follow these steps:

Installation
================================

To build the toolkit: see `./INSTALL`.  These instructions are valid for UNIX
systems including various flavors of Linux; Darwin; and Cygwin (has not been
tested on more "exotic" varieties of UNIX).  For Windows installation
instructions (excluding Cygwin), see `windows/INSTALL`.

Running
================================
To run, please use the egs/sre10/v1/run_hmdb51.sh file. Remember to give executable 
permissions to this file (for Linux "chmod +x egs/sre10/v1/run_hmdb51.sh").

Place the HOF features downloaded above into the data folder of the 
