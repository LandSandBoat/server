/*
===========================================================================

  Copyright (c) 2021 Eden Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#ifndef _LOS_TREE_H
#define _LOS_TREE_H

#include "common/cbasetypes.h"

#include "common.h"
#include "los_tree_node.h"

class LosTree
{
public:
    LosTree(Triangle* elements, int elementCount);
    ~LosTree();

    LosTreeNodeStats GetStats();

    std::optional<Vector3D> DoesRayCollide(Vector3D& rayOrigin, Vector3D& rayVector) const;

private:
    Triangle* elements;
    int*      elementNexts;
    size_t    elementCount;

    LosTreeNode* root = nullptr;
};

#endif // _LOS_TREE_H
