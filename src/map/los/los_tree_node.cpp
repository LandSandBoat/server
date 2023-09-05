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

#include "los_tree_node.h"

#include "common/utils.h"

#define TOP_ANGLE    M_PI / 5
#define BOTTOM_ANGLE M_PI - M_PI / 5

template <typename F>
int splitArraySort(int* arr, int start, int end, F&& splitFunc)
{
    while (start < end)
    {
        while (start < end && splitFunc(arr[start]))
        {
            ++start;
        }

        while (start < end && !splitFunc(arr[end]))
        {
            --end;
        }

        if (start >= end)
        {
            break;
        }

        std::swap(arr[start++], arr[end--]);
    }
    return start;
}

LosTreeNode::LosTreeNode(
    Triangle*    elements,
    BoundingBox* boundingBoxes,
    int*         elementNexts,
    int*         elementIndices,
    int          indexStart,
    int          indexEnd,
    int          splitsLeft,
    float        boxSizeThreshold,
    size_t       elementsThreshold,
    bool         normalSplit)
{
    int indexCount = indexEnd - indexStart + 1;
    if (indexCount <= 0)
    {
        // No elements to store in this node.
        return;
    }

    if (splitsLeft <= 0 || (int)elementsThreshold >= indexCount)
    {
        SetElements(elements, elementNexts, elementIndices, indexStart, indexEnd);
        return;
    }

    int indexSplit = indexStart;

    // Split by the normal vector of the triangle to separate vertical and horizontal layers
    if (normalSplit)
    {
        splitAxis = Axis::None;

        // clang-format off
        indexSplit = splitArraySort(elementIndices, indexStart, indexEnd, [&elements](int index)
        {
            auto element = elements[index];
            auto normal  = (element.vertices[1] - element.vertices[0]).crossProduct(element.vertices[2] - element.vertices[0]);
            auto angle   = acosf(normal.y / normal.magnitude());
            return angle <= TOP_ANGLE || angle >= BOTTOM_ANGLE;
        });
        // clang-format on
    }
    else
    {
        // Use longest axis as heuritistic for spliting the node, and split by its median of objects.
        BoundingBox nodeBox    = boundingBoxes[indexStart];
        float       medians[3] = { 0, 0, 0 };
        for (auto i = indexStart; i <= indexEnd; i++)
        {
            auto& bounds = boundingBoxes[elementIndices[i]];
            nodeBox.expandTo(bounds);
            medians[(int)Axis::X] += bounds.getAxisMiddle(Axis::X);
            medians[(int)Axis::Y] += bounds.getAxisMiddle(Axis::Y);
            medians[(int)Axis::Z] += bounds.getAxisMiddle(Axis::Z);
        }

        float biggestAxisSize = 0;
        splitAxis             = Axis::None;
        for (auto i = 0; i < 3; i++)
        {
            medians[i] /= indexCount;
            float axisSize = nodeBox.getAxisSize((Axis)i);
            if (axisSize > biggestAxisSize)
            {
                biggestAxisSize = axisSize;
                splitAxis       = (Axis)i;
            }
        }

        if (nodeBox.getAxisSize(splitAxis) < boxSizeThreshold)
        {
            SetElements(elements, elementNexts, elementIndices, indexStart, indexEnd);
            return;
        }

        // Split the nodes based on the axis
        float splitValue = medians[(int)splitAxis];
        leftMax          = nodeBox.getAxisMin(splitAxis);
        rightMin         = nodeBox.getAxisMax(splitAxis);

        // clang-format off
        indexSplit = splitArraySort(elementIndices, indexStart, indexEnd, [&boundingBoxes, &splitValue, this](int index)
        {
            auto& bounds = boundingBoxes[index];
            if (bounds.getAxisMiddle(splitAxis) < splitValue)
            {
                leftMax = std::max(leftMax, bounds.getAxisMax(splitAxis));
                return true;
            }
            else
            {
                rightMin = std::min(rightMin, bounds.getAxisMin(splitAxis));
                return false;
            }
        });
        // clang-format on
    }

    if (indexSplit > indexStart)
    {
        left = new LosTreeNode(elements, boundingBoxes, elementNexts, elementIndices, indexStart, indexSplit - 1, splitsLeft - 1, boxSizeThreshold, elementsThreshold);
        minY = left->minY;
        maxY = left->maxY;
    }

    if (indexSplit <= indexEnd)
    {
        right = new LosTreeNode(elements, boundingBoxes, elementNexts, elementIndices, indexSplit, indexEnd, splitsLeft - 1, boxSizeThreshold, elementsThreshold);
        if (right->minY < minY)
        {
            minY = right->minY;
        }
        if (right->maxY > maxY)
        {
            maxY = right->maxY;
        }
    }
}

LosTreeNode::~LosTreeNode()
{
    destroy(left);
    destroy(right);
}

void LosTreeNode::SetElements(Triangle* elements, int* elementNexts, int* elementIndices, int indexStart, int indexEnd)
{
    // Store elements in a singly-linked list for this node.
    headElementIdx = elementIndices[indexStart];
    auto& element  = elements[headElementIdx];
    for (auto& vertex : element.vertices)
    {
        if (vertex.y > maxY)
        {
            maxY = vertex.y;
        }
        if (vertex.y < minY)
        {
            minY = vertex.y;
        }
    }

    for (int i = indexStart + 1; i <= indexEnd; i++)
    {
        auto& element = elements[elementIndices[i]];
        for (auto& vertex : element.vertices)
        {
            if (vertex.y > maxY)
            {
                maxY = vertex.y;
            }
            if (vertex.y < minY)
            {
                minY = vertex.y;
            }
        }
        elementNexts[elementIndices[i - 1]] = elementIndices[i];
    }
}

std::optional<Vector3D> LosTreeNode::DoesRayCollide(BoundingBox& bounds, Vector3D& rayOrigin, Vector3D& rayVector, int* elementNexts, Triangle* elements) const
{
    TracyZoneScoped;
    if (bounds.coords[2] > maxY || bounds.coords[3] < minY)
    {
        return std::nullopt;
    }

    if (headElementIdx != -1)
    {
        int idx = headElementIdx;
        while (idx != -1)
        {
            if (auto vec = elements[idx].doesRayIntersect(rayOrigin, rayVector))
            {
                return vec;
            }
            idx = elementNexts[idx];
        }

        return std::nullopt;
    }

    // Special case if split axis is not defined. Both children are visited.
    if (splitAxis == Axis::None)
    {
        if (right)
        {
            if (auto rightPos = right->DoesRayCollide(bounds, rayOrigin, rayVector, elementNexts, elements))
            {
                return rightPos;
            }
        }

        if (left)
        {
            if (auto leftPos = left->DoesRayCollide(bounds, rayOrigin, rayVector, elementNexts, elements))
            {
                return leftPos;
            }
        }

        return std::nullopt;
    }

    if (right && bounds.getAxisMax(splitAxis) >= rightMin)
    {
        if (auto rightPos = right->DoesRayCollide(bounds, rayOrigin, rayVector, elementNexts, elements))
        {
            return rightPos;
        }
    }

    if (left && bounds.getAxisMin(splitAxis) <= leftMax)
    {
        if (auto leftPos = left->DoesRayCollide(bounds, rayOrigin, rayVector, elementNexts, elements))
        {
            return leftPos;
        }
    }

    return std::nullopt;
}

LosTreeNodeStats LosTreeNode::GetStats(int* elementNexts, Triangle* elements)
{
    TracyZoneScoped;
    LosTreeNodeStats stats;
    if (headElementIdx != -1)
    {
        int count         = 1;
        stats.boundingBox = elements[headElementIdx].getBoundingBox();

        int next = elementNexts[headElementIdx];
        while (next != -1)
        {
            stats.boundingBox.expandTo(elements[next].getBoundingBox());
            next = elementNexts[next];
            count++;
        }

        stats.emptyNodes  = 0;
        stats.nodes       = 1;
        stats.maxDepth    = 1;
        stats.minDepth    = 1;
        stats.minElements = count;
        stats.maxElements = count;

        stats.maxAxis = std::max(std::max(stats.boundingBox.getAxisSize(Axis::X), stats.boundingBox.getAxisSize(Axis::Y)), stats.boundingBox.getAxisSize(Axis::Z));

        return stats;
    }

    LosTreeNodeStats leftStats  = left ? left->GetStats(elementNexts, elements) : LosTreeNodeStats();
    LosTreeNodeStats rightStats = right ? right->GetStats(elementNexts, elements) : LosTreeNodeStats();
    stats.nodes                 = 1 + leftStats.nodes + rightStats.nodes;
    stats.emptyNodes            = (left ? leftStats.emptyNodes : 1) + (rightStats.emptyNodes ? 0 : 1);
    stats.minDepth              = std::min(left ? leftStats.minDepth : 0, right ? rightStats.minDepth : 0) + 1;
    stats.maxDepth              = std::max(left ? leftStats.maxDepth : 0, right ? rightStats.maxDepth : 0) + 1;
    stats.minElements           = std::min(leftStats.minElements, rightStats.minElements);
    stats.maxElements           = std::max(leftStats.maxElements, rightStats.maxElements);
    stats.maxAxis               = std::max(leftStats.maxAxis, rightStats.maxAxis);

    if (!left)
    {
        stats.boundingBox = rightStats.boundingBox;
    }
    else if (!right)
    {
        stats.boundingBox = leftStats.boundingBox;
    }
    else
    {
        stats.boundingBox = leftStats.boundingBox;
        stats.boundingBox.expandTo(rightStats.boundingBox);
    }

    return stats;
}
