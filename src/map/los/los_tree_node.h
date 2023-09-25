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

#ifndef _LOS_TREE_NODE_H
#define _LOS_TREE_NODE_H

#include "common/cbasetypes.h"

#include "common.h"

struct LosTreeNodeStats
{
    int minDepth    = INT_MAX;
    int maxDepth    = INT_MIN;
    int minElements = INT_MAX;
    int maxElements = INT_MIN;
    int nodes       = 0;
    int emptyNodes  = 0;

    float maxAxis = 0;

    BoundingBox boundingBox;
};

class LosTreeNode
{
public:
    LosTreeNode(
        Triangle*    elements,
        BoundingBox* boundingBoxes,
        int*         elementNexts,
        int*         elementIndices,
        int          indexStart,
        int          indexEnd,
        int          splitsLeft,
        float        boxSizeThreshold,
        size_t       elementsThreshold,
        bool         normalSplit = false);

    ~LosTreeNode();

    LosTreeNodeStats GetStats(int* elementNexts, Triangle* elements);

    std::optional<Vector3D> DoesRayCollide(
        BoundingBox& bounds,
        Vector3D&    rayOrigin,
        Vector3D&    rayVector,
        int*         elementNexts,
        Triangle*    elements) const;

private:
    void SetElements(Triangle* elements, int* elementNexts, int* elementIndices, int indexStart, int indexEnd);
    int  headElementIdx = -1;

    // Keep bounds for Y-axis since rays are usually mostly horizontal, so we can skip a bunch of triangle checks.
    float minY = 100000.0f;
    float maxY = -100000.0f;

    Axis         splitAxis = Axis::None;
    float        leftMax   = 0;
    float        rightMin  = 0;
    LosTreeNode* left      = nullptr;
    LosTreeNode* right     = nullptr;
};

#endif // _LOS_TREE_NODE_H
