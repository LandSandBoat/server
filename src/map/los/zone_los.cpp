/*
===========================================================================

  Copyright (c) 2021 Eden Dev Team

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

#include "zone_los.h"

#ifndef FAST_OBJ_IMPLEMENTATION
#define FAST_OBJ_IMPLEMENTATION
#include <fast_obj.h>
#endif

#include "common/zlib.h"
#include "entities/baseentity.h"

#ifdef LOS_DEBUG
float totalMemory = 0;
#endif

namespace
{
    float ENTITY_HEIGHT = 2.0f;
}

ZoneLos::ZoneLos(Triangle* elements, int elementCount)
: tree(LosTree(elements, elementCount))
{
}

ZoneLos* ZoneLos::Load(uint16 zoneId, std::string const& pathToObj)
{
    TracyZoneScoped;
    // Check if file exists before loading the OBJ model.
    if (FILE* file = fopen(pathToObj.c_str(), "r"))
    {
        fclose(file);
    }
    else
    {
        // No matching line-of-sight mesh file found, so skip it for this zone silently.
        return nullptr;
    }

    fastObjMesh* mesh = fast_obj_read(pathToObj.c_str());
    if (!mesh)
    {
        ShowWarning("Failed to load line-of-sight mesh: %s", pathToObj);
        return nullptr;
    }

    Triangle* elements = new Triangle[mesh->face_count];

    // Loop over groups
    unsigned int index_offset = 0;
    for (unsigned int gi = 0; gi < mesh->group_count; gi++)
    {
        const fastObjGroup& grp = mesh->groups[gi];

        // Loop over faces
        for (unsigned int fi = 0; fi < mesh->face_count; fi++)
        {
            unsigned int fv = mesh->face_vertices[grp.face_offset + fi];

            if (fv != 3)
            {
                ShowWarning("Skipping polygon with %d vertices. Expected 3.", fv);
                continue;
            }

            // Loop over vertices in the face.
            for (unsigned int v = 0; v < fv; v++)
            {
                const fastObjIndex& mi   = mesh->indices[grp.index_offset + index_offset + v];
                elements[fi].vertices[v] = { mesh->positions[3 * mi.p + 0], -mesh->positions[3 * mi.p + 1], -mesh->positions[3 * mi.p + 2] };
            }
            index_offset += fv;
        }
    }

    auto zoneLos = new ZoneLos(elements, mesh->face_count);

#ifdef LOS_DEBUG
    auto stats = zoneLos->tree.GetStats();
    ShowDebug("");
    ShowDebug("File: %s", pathToObj);
    ShowDebug("Nodes: %d", stats.nodes);
    ShowDebug("Empty nodes: %d", stats.emptyNodes);
    ShowDebug("Max elements: %d", stats.maxElements);
    float treeMem    = stats.nodes * sizeof(LosTreeNode) / 1000000.f;
    float elementMem = (mesh->face_count * sizeof(Triangle) + mesh->face_count * sizeof(int)) / 1000000.f;
    totalMemory += treeMem + elementMem;
    ShowDebug("Tree memory (%db): %.2f mb", sizeof(LosTreeNode), treeMem);
    ShowDebug("Element memory (%db): %.2f mb", sizeof(Triangle), elementMem);
    ShowDebug("Total memory: %.2f mb", totalMemory);
#endif

    fast_obj_destroy(mesh);

    return zoneLos;
}

bool ZoneLos::CanEntitySee(CBaseEntity* source, CBaseEntity* target) const
{
    TracyZoneScoped;
    return CanEntitySee(source, target->loc.p);
}

bool ZoneLos::CanEntitySee(CBaseEntity* source, position_t const& targetPointBase) const
{
    TracyZoneScoped;
    return !DoesRayCollide({ source->loc.p.x, source->loc.p.y - ENTITY_HEIGHT, source->loc.p.z }, { targetPointBase.x, targetPointBase.y - ENTITY_HEIGHT, targetPointBase.z });
}

std::optional<Vector3D> ZoneLos::Raycast(CBaseEntity* source, CBaseEntity* target) const
{
    TracyZoneScoped;
    return Raycast(source->loc.p, target->loc.p);
}

std::optional<Vector3D> ZoneLos::Raycast(position_t const& source, position_t const& target) const
{
    TracyZoneScoped;
    return DoesRayCollide({ source.x, source.y, source.z }, { target.x, target.y, target.z });
}

std::optional<Vector3D> ZoneLos::DoesRayCollide(Vector3D rayOrigin, Vector3D rayEnd) const
{
    TracyZoneScoped;
    return tree.DoesRayCollide(rayOrigin, rayEnd);
}
