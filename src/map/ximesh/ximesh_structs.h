/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#pragma once

#include "common/cbasetypes.h"
#include "map/enums/terrain_type.h"
#include "map/ximesh/vector3.h"

#include <array>
#include <limits>
#include <optional>
#include <vector>

//
// Binary format structs - packed representations of the on-disk ximesh layout.
// Reference: https://github.com/InoUno/xi-visualizer/blob/main/src/graphics/ximesh.ts
//
// After decompression:
//   [XimeshHeader]                        20 bytes
//   [u32 x cellCount]                     cell offset table
//   ...
//
// Cell (at offset):
//   [XimeshCellHeader]                    reserved u32 + entry count u16
//   [XimeshCellEntry x entryCount]        block offset + placement offset
//
// Block (at blockOffset):
//   [u16 vertexCount] [u16 triangleCount] [u16 barrierFlag] [u16 pad]
//   [float x vertexCount x 3]             local-space xyz
//   [u16 x triangleCount x 3]             indices (4-byte aligned)
//   [TriangleMeta x triangleCount]        material + barrier per tri
//
// Placement (at placementOffset):
//   [PlacementFlags]                      u32 bitfield
//   [float x 12]                          3x3 rotation (col-major) + vec3 translation
//

#pragma pack(push, 1)
struct XimeshHeader
{
    uint16 gridWidth{};
    uint16 gridHeight{};
    uint32 blockSectionOffset{};
    uint32 placementSectionOffset{};
    uint16 blockCount{};
    uint16 placementCount{};
    uint32 wideSearch{};
};

struct XimeshCellHeader
{
    uint32 reserved{};
    uint16 entryCount{};
};

struct XimeshCellEntry
{
    uint32 blockOffset{};
    uint32 placementOffset{};
};

struct TriangleMeta
{
    uint8 material : 4;
    uint8 barrier : 1;
    uint8 padding : 3;
};

struct PlacementFlags
{
    uint32 padding0 : 2;
    uint32 roofed : 1;
    uint32 mapIdLow : 3;
    uint32 padding1 : 20;
    uint32 mapIdHigh : 2;
    uint32 padding2 : 4;
};
#pragma pack(pop)

//
// Intermediate structs - parsed, in-memory representations built from the
// binary format above.
//

struct MeshBlock
{
    std::vector<float>        vertices;      // x,y,z interleaved (vertexCount * 3)
    std::vector<uint16>       indices;       // 3 per triangle
    std::vector<TriangleMeta> metas;         // 1 per triangle
    bool                      hasBarriers{}; // true if any triangle in this block is a barrier
};

struct MeshPlacement
{
    std::array<float, 9> rotation{}; // 3x3 column-major
    std::array<float, 3> translation{};
    uint8                mapId{};
    bool                 roofed{};
    float                yMin{ std::numeric_limits<float>::max() };
    float                yMax{ std::numeric_limits<float>::lowest() };
};

struct CellEntry
{
    uint16 blockIdx;
    uint16 placementIdx;
};

struct CellSpan
{
    uint32 offset : 24;
    uint32 count : 8;
};

// Result of a vertical downcast (query). Answers "what floor is under this XZ position?"
struct CellHit
{
    TerrainType type{ TerrainType::None };
    uint8       mapId{};
    bool        roofed{};
    bool        barrier{};
    float       y{}; // world-space floor height at the query point
};

struct YOffsets
{
    float start;
    float end;
};

struct YRange
{
    float min{ std::numeric_limits<float>::max() };
    float max{ std::numeric_limits<float>::lowest() };
};

// Result of a directional ray cast (rayIntersect / getPositionInfo). Answers "where did this ray hit geometry?"
struct RayHitInfo
{
    Vector3              intersection{}; // 3D hit point in object space
    float                distanceSq{};
    const MeshPlacement* placement{};
    TerrainType          type{ TerrainType::None };
    bool                 barrier{};
};
