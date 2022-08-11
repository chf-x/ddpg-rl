/**
 * Copyright 2022 Huawei Technologies Co., Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <limits>
#include "vanilla_impl.cuh"

__global__ void SelectionPolicy(int *explore_count, float *total_reward, int *parent_explore_count, float *uct_ptr,
                                float *uct_value) {
  if (*explore_count == 0) {
    uct_value[0] = std::numeric_limits<float>::infinity();
    return;
  }
  uct_value[0] =
    *total_reward / *explore_count + *uct_ptr * std::sqrt(std::log(*parent_explore_count) / *explore_count);
  return;
}

__global__ void Update(int *explore_count, float *total_reward, float *values, int player) {
  *explore_count += 1;
  *total_reward += values[player];
}

void CalSelectionPolicy(int *explore_count, float *total_reward, int *parent_explore_count, float *uct_ptr,
                        float *uct_value, cudaStream_t cuda_stream) {
  dim3 blockSize(1);
  dim3 gridSize(1);
  SelectionPolicy<<<gridSize, blockSize, 0, cuda_stream>>>(explore_count, total_reward, parent_explore_count, uct_ptr,
                                                           uct_value);
  return;
}

void CalUpdate(int *explore_count, float *total_reward, float *values, int player, cudaStream_t cuda_stream) {
  dim3 blockSize(1);
  dim3 gridSize(1);
  Update<<<gridSize, blockSize, 0, cuda_stream>>>(explore_count, total_reward, values, player);
  return;
}
