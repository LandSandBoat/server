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

struct NavMeshConfig
{
    float cellSize{ 0.5f };               // Previous xiNavmeshes value: 0.4
    float cellHeight{ 0.4f };             // Previous xiNavmeshes value: 0.2
    float walkableSlopeAngle{ 46.0f };    // Previous xiNavmeshes value: 46.0
    float agentHeight{ 2.0f };            // Previous xiNavmeshes value: 1.8
    float agentRadius{ 0.5f };            // Previous xiNavmeshes value: 0.3
    float agentMaxClimb{ 0.6f };          // Previous xiNavmeshes value: 0.6
    float maxEdgeLen{ 0.0f };             // Previous xiNavmeshes value: 12.0
    float maxSimplificationError{ 1.3f }; // Previous xiNavmeshes value: 1.3
    int   minRegionArea{ 8 };             // Previous xiNavmeshes value: 8
    int   mergeRegionArea{ 20 };          // Previous xiNavmeshes value: 20
    int   maxVertsPerPoly{ 6 };           // Previous xiNavmeshes value: 6
    float detailSampleDist{ 6.0f };       // Previous xiNavmeshes value: 6.0
    float detailSampleMaxError{ 1.0f };   // Previous xiNavmeshes value: 1.0
    int   tileSize{ 64 };                 // Previous xiNavmeshes value: 256

    bool filterLowHangingObstacles{ true };
    bool filterLedgeSpans{ true };
    bool filterWalkableLowHeightSpans{ true };
};
