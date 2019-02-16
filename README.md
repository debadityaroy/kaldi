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
1.To run, please use the egs/sre10/v1/run_hmdb51.sh file. Remember to give executable 
permissions to this file (for Linux "chmod +x egs/sre10/v1/run.sh").

2. Create a folder anywhere e.g. /home/debaditya/HOF. 
The folder you created above is the variable "parent_dir" in egs/sre10/v1/run.sh. 

3. Download and extract the features given above into that folder.

4. To run the code now navigate to the egs/sre10/v1/ directory in the code folder and use the following command

./run.sh "parent_dir"
5.The scores you should obtain will be in EER (equal error rate). They should be as follows:

6. Classification accuracy reported in the paper is calculated as 100-EER. However, 

7. These scores are based on cosine-scoring, LDA and PLDA applied to action-vectors.

8. For discriminative embedding using Siamese networks, the action-vectors have to be extracted from the folders 

Training action-vectors : <parent_dir>/exp/ivectors_hmdb51_train_512_200     
Testing action-vectors : <parent_dir>/exp/ivectors_hmdb51_test_512_200

where 
512: number of Gaussian mixtures (num_components in egs/sre10/v1/run.sh)
200: action-vector dimension (ivec_dim in egs/sre10/v1/run.sh)

You can change both these parameters and new directories will be created based on the values.

9. Please contact Debaditya Roy (cs13p1001@iith.ac.in) to know more about the creation the feature files.

