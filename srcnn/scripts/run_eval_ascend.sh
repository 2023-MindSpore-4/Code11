#!/bin/bash
# Copyright 2021 Huawei Technologies Co., Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============================================================================

if [ $# -ne 3 ]
then
    echo "Usage: bash run_eval_ascend.sh [DEVICE_ID] [DATASET_PATH] [CHECKPOINT_PATH]"
exit 1
fi

# check checkpoint file
if [ ! -f $3 ]
then
    echo "error: CHECKPOINT_PATH=$3 is not a file"    
exit 1
fi

BASEPATH=$(cd "`dirname $0`" || exit; pwd)
export PYTHONPATH=${BASEPATH}:$PYTHONPATH

if [ -d "./eval" ];
then
    rm -rf ./eval
fi
mkdir ./eval

export DEVICE_ID="$1"

python ${BASEPATH}/../eval.py \
        --data_path=$2 \
        --checkpoint_path=$3 > eval/eval.log 2>&1 &