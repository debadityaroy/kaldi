This repository accompanies the paper titled [Unsupervised Action Recognition using Universal Attribute Modelling](https://www.researchgate.net/publication/329665918_Unsupervised_Universal_Attribute_Modelling_for_Action_Recognition?_sg=zOUAMlSi15QRc2isDfPBzxOdkDzoRLxcKgCZCh_ULGVUdVcdQ_Xdu1rjnWjnddOfxSqfto8lTkr40LFxWmewJ0hHeFOvkItp97YLIjdD.2X3qealrl1T2ucwDGXQjPt9Irs7GOZIU_fi7z7S7mIiGnz1HksmNDe82sHVXwWpyAzZXVTF_bt87EOPab5AQoQ) and [Action Recognition based on discriminative embedding of actions using Siamese networks](https://www.researchgate.net/publication/327995636_Action_Recognition_Based_on_Discriminative_Embedding_of_Actions_Using_Siamese_Networks?_sg=zOUAMlSi15QRc2isDfPBzxOdkDzoRLxcKgCZCh_ULGVUdVcdQ_Xdu1rjnWjnddOfxSqfto8lTkr40LFxWmewJ0hHeFOvkItp97YLIjdD.2X3qealrl1T2ucwDGXQjPt9Irs7GOZIU_fi7z7S7mIiGnz1HksmNDe82sHVXwWpyAzZXVTF_bt87EOPab5AQoQ), for generating action-vectors.

Using this repository, one can reproduce the results on the HMDB51 dataset for Histogram of Optical Flow (HOF) features. These HOF features are extracted using [Improved Dense Trajectory framework] https://lear.inrialpes.fr/people/wang/improved_trajectories.

We provide the extracted HOF features for the HMDB51 dataset [here](https://drive.google.com/drive/folders/1kpHoZQvDgfUItu-pqbS8SrZQyg0yimaf?usp=sharing)

In order to run the code, follow these steps:

Installation
================================

To build the toolkit: see `./INSTALL`.  These instructions are valid for UNIX
systems including various flavors of Linux; Darwin; and Cygwin (has not been
tested on more "exotic" varieties of UNIX).  For Windows installation
instructions (excluding Cygwin), see `windows/INSTALL`.

This tutorial should help in case of any problems http://kaldi-asr.org/doc/tutorial_setup.html.

Running
================================

1. Create a folder anywhere e.g. /home/debaditya/HOF. 
The full path to the folder you created above is the variable "parent_dir" in egs/sre10/v1/run.sh. 

2. Download and extract the features given above into that folder. The folder structure should look like this
```
   parent_dir
   +--data
   |  +--hmd51_test
   |  +--hmdb51_train
```

The path to the features need to be changed to the parent_dir. Navigate to egs/sre10/v1/ directory in the code folder and run
```
change_path.py parent_dir
```
Remember to give executable permissions to this file (for Linux "chmod +x change_path.sh").

3. To run following command
```
./run.sh parent_dir
```
Remember to give executable permissions to this file (for Linux "chmod +x run.sh").

4.The scores you should obtain will be in EER (equal error rate). Classification accuracy reported in the paper is calculated as 100-EER. 

5. These scores are based on cosine-scoring, LDA and PLDA applied to action-vectors.

6. For discriminative embedding using Siamese networks, the action-vectors have to be extracted from the folders 

Training action-vectors : <parent_dir>/exp/ivectors_hmdb51_train_512_200     
Testing action-vectors : <parent_dir>/exp/ivectors_hmdb51_test_512_200

where 
512: number of Gaussian mixtures (num_components in egs/sre10/v1/run.sh)
200: action-vector dimension (ivec_dim in egs/sre10/v1/run.sh)

You can change both these parameters and new directories will be created based on the values.

7. Please contact Debaditya Roy (cs13p1001@iith.ac.in) to know more about the creation the feature files or extraction of action-vectors for further processing.

