#!/bin/bash
# Copyright 2015   David Snyder
#           2015   Johns Hopkins University (Author: Daniel Garcia-Romero)
#           2015   Johns Hopkins University (Author: Daniel Povey)
# Apache 2.0.
#
# See README.txt for more info on "$parent_dir"data required.
# Results (EERs) are inline in comments below.

. cmd.sh
. path.sh
set -e
parent_dir=$1
parent_dir2=$2
trials="$parent_dir"data/hmdb51_test/trials
num_components=512 # 2048, 1024, 512, 256
ivec_dim=200 #600, 400, 200

#if [ -f "$parent_dir"exp/extractor_hmdb51_"$num_components"_"$ivec_dim"/final.ie ]
#    then rm "$parent_dir"exp/extractor_hmdb51_"$num_components"_"$ivec_dim"/final.ie
#fi
 
# compute only once for one feature

# Reduce the amount of training "$parent_dir"data for the UBM.
#utils/subset_data_dir.sh "$parent_dir"data/train 50 "$parent_dir"data/train
#utils/subset_data_dir.sh data/train 9500 data/train_all


# Train UBM and i-vector extractor.
sid/train_diag_ubm.sh --nj 20 --cmd "$train_cmd -l mem_free=20G,ram_free=20G"\
    "$parent_dir"data/hmdb51_train $num_components \
    "$parent_dir"exp/diag_ubm_hmdb51_$num_components


gmm-global-to-fgmm "$parent_dir"exp/diag_ubm_hmdb51_$num_components/final.dubm "$parent_dir"exp/diag_ubm_hmdb51_$num_components/final.ubm

sid/train_ivector_extractor.sh --cmd "$train_cmd -l mem_free=35G,ram_free=35G" --nj 4 --num-processes 5 \
  --ivector-dim $ivec_dim \
  --num-iters 5 "$parent_dir"exp/diag_ubm_hmdb51_$num_components/final.ubm "$parent_dir"data/hmdb51_train \
  "$parent_dir"exp/extractor_hmdb51_"$num_components"_"$ivec_dim"

# Extract i-vectors.
sid/extract_ivectors.sh --cmd "$train_cmd -l mem_free=6G,ram_free=6G" --nj 20 \
  "$parent_dir"exp/extractor_hmdb51_"$num_components"_"$ivec_dim" "$parent_dir"data/hmdb51_train \
  "$parent_dir"exp/ivectors_hmdb51_train_"$num_components"_"$ivec_dim"


sid/extract_ivectors.sh --cmd "$train_cmd -l mem_free=6G,ram_free=6G" --nj 20 \
  "$parent_dir"exp/extractor_hmdb51_"$num_components"_"$ivec_dim" "$parent_dir"data/hmdb51_test \
  "$parent_dir"exp/ivectors_hmdb51_test_"$num_components"_"$ivec_dim"


#scoring
local/cosine_scoring.sh "$parent_dir"data/hmdb51_train "$parent_dir"data/hmdb51_test \
  "$parent_dir"exp/ivectors_hmdb51_train_"$num_components"_"$ivec_dim" "$parent_dir"exp/ivectors_hmdb51_test_"$num_components"_"$ivec_dim" \
   $trials "$parent_dir"local/scores_hmdb51_"$num_components"_"$ivec_dim"

local/lda_scoring.sh "$parent_dir"data/hmdb51_train "$parent_dir"data/hmdb51_train "$parent_dir"data/hmdb51_test \
   "$parent_dir"exp/ivectors_hmdb51_train_"$num_components"_"$ivec_dim" "$parent_dir"exp/ivectors_hmdb51_train_"$num_components"_"$ivec_dim" \
   "$parent_dir"exp/ivectors_hmdb51_test_"$num_components"_"$ivec_dim" $trials "$parent_dir"local/scores_hmdb51_"$num_components"_"$ivec_dim"

local/plda_scoring.sh "$parent_dir"data/hmdb51_train "$parent_dir"data/hmdb51_train "$parent_dir"data/hmdb51_test \
   "$parent_dir"exp/ivectors_hmdb51_train_"$num_components"_"$ivec_dim" "$parent_dir"exp/ivectors_hmdb51_train_"$num_components"_"$ivec_dim" \
   "$parent_dir"exp/ivectors_hmdb51_test_"$num_components"_"$ivec_dim" $trials "$parent_dir"local/scores_hmdb51_"$num_components"_"$ivec_dim"


eer=`compute-eer <(python local/prepare_for_eer.py $trials "$parent_dir"local/scores_hmdb51_${num_components}_${ivec_dim}/cosine_scores) 2> /dev/null`
echo 'cosine: '$eer
eer=`compute-eer <(python local/prepare_for_eer.py $trials "$parent_dir"local/scores_hmdb51_${num_components}_${ivec_dim}/lda_scores) 2> /dev/null`
echo 'lda: '$eer
eer=`compute-eer <(python local/prepare_for_eer.py $trials "$parent_dir"local/scores_hmdb51_${num_components}_${ivec_dim}/plda_scores) 2> /dev/null`
echo 'plda: '$eer
