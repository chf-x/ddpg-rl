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

#ifndef MINDSPORE_RL_UTILS_MCTS_VANILLA_H_
#define MINDSPORE_RL_UTILS_MCTS_VANILLA_H_

#include <utils/mcts/mcts_factory.h>
#include <utils/mcts/mcts_tree_node.h>
#include <string>

class VanillaTreeNode : public MonteCarloTreeNode {
 public:
  VanillaTreeNode(const std::string &name, int action, float prior, float *init_reward, int player, int64_t tree_handle,
                  MonteCarloTreeNodePtr parent_node, int row, int state_size)
      : MonteCarloTreeNode(name, action, prior, init_reward, player, tree_handle, parent_node, row, state_size) {}

  bool SelectionPolicy(float *uct_value) const override;
  bool Update(float *value) override;
};
MS_REG_NODE(Vanilla, VanillaTreeNode);

#endif  // MINDSPORE_RL_UTILS_MCTS_VANILLA_H_
