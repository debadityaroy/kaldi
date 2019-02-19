'''

Author: Debaditya Roy

appends path defined in parent_dir to feats_og.scp files in both 
train and test directory

usage: python change_path.py <parent_dir>
'''

import os
import sys

parent_dir = sys.argv[1]

# reads the existing scp files in train and test
og_train_scp = open(parent_dir+'data/hmdb51_train/feats_og.scp','r').readlines()
og_test_scp = open(parent_dir+'data/hmdb51_test/feats_og.scp','r').readlines()

# creates new scp files
new_train_scp = open(parent_dir+'data/hmdb51_train/feats.scp','w')
new_test_scp = open(parent_dir+'data/hmdb51_test/feats.scp','w')


for line in og_train_scp:
    parts = line.strip('\n').split(' ')
    new_train_scp.write(parts[0]+' '+parent_dir+parts[1]+'\n')

for line in og_test_scp:
    parts = line.strip('\n').split(' ')
    new_test_scp.write(parts[0]+' '+parent_dir+parts[1]+'\n')

new_train_scp.close()
new_test_scp.close()
