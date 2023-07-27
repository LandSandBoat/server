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

#include "los_tree.h"

LosTree::LosTree(Triangle* elements, int elementCount)
{
    this->elements     = elements;
    this->elementNexts = new int[elementCount];
    this->elementCount = elementCount;

    BoundingBox* boundingBoxes = new BoundingBox[elementCount];
    int*         indices       = new int[elementCount];

    for (int i = 0; i < elementCount; i++)
    {
        indices[i]            = i;
        this->elementNexts[i] = -1;

        this->elements[i] = elements[i];
        boundingBoxes[i]  = elements[i].getBoundingBox();
    }

    root = new LosTreeNode(this->elements, boundingBoxes, this->elementNexts, indices, 0, elementCount - 1, 100, 1, 5, true);

    destroy_arr(boundingBoxes);
    destroy_arr(indices);
}

LosTree::~LosTree()
{
    destroy(root);
    destroy_arr(elements);
    destroy_arr(elementNexts);
}

LosTreeNodeStats LosTree::GetStats()
{
    TracyZoneScoped;
    return root->GetStats(this->elementNexts, this->elements);
}

std::optional<Vector3D> LosTree::DoesRayCollide(Vector3D& rayOrigin, Vector3D& rayEnd) const
{
    TracyZoneScoped;
    BoundingBox bounds = BoundingBox();
    bounds.coords[0]   = std::min(rayOrigin.x, rayEnd.x);
    bounds.coords[1]   = std::max(rayOrigin.x, rayEnd.x);
    bounds.coords[2]   = std::min(rayOrigin.y, rayEnd.y);
    bounds.coords[3]   = std::max(rayOrigin.y, rayEnd.y);
    bounds.coords[4]   = std::min(rayOrigin.z, rayEnd.z);
    bounds.coords[5]   = std::max(rayOrigin.z, rayEnd.z);

    Vector3D rayVector = rayEnd - rayOrigin;

    return root->DoesRayCollide(bounds, rayOrigin, rayVector, this->elementNexts, this->elements);
}
