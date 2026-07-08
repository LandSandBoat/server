-----------------------------------
-- func: rebuildnavmesh
-- desc: Rebuild the navmesh for the current zone with configurable parameters
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = ''
}

local config =
{
    -- Horizontal voxel resolution. Smaller = more accurate but slower to build (more memory too?)
    --
    -- Docs:
    -- The xz-plane cell size to use for fields. [Limit: > 0] [Units: wu]
    cellSize = 0.5,

    -- Vertical voxel resolution. Smaller = more accurate height detection, around drops and slope edges.
    --
    -- Docs:
    -- The y-axis cell size to use for fields. [Limit: > 0] [Units: wu]
    cellHeight = 0.4,

    -- Slopes steeper than this angle (in degrees) are marked as unwalkable.
    --
    -- Docs:
    -- The maximum slope that is considered walkable. [Limits: 0 <= value < 90] [Units: Degrees]
    walkableSlopeAngle = 46.0,

    -- Minimum clearance above the floor for an area to be walkable (in wu).
    -- Areas with ceilings lower than this are excluded (doorframes, overhangs).
    --
    -- Docs:
    -- Minimum floor to 'ceiling' height that will still allow the floor area to
    -- be considered walkable. [Limit: >= 3] [Units: vx]
    agentHeight = 2.0,

    -- How far the walkable area is shrunk inward from walls and edges (in wu).
    -- Higher values keep agents further from drops and obstacles, but narrow
    -- paths (doorways, bridges) may disappear.
    --
    -- Docs:
    -- The distance to erode/shrink the walkable area of the heightfield away from
    -- obstructions. [Limit: >=0] [Units: vx]
    agentRadius = 0.5,

    -- Maximum step height the agent can climb (in wu). Ledges taller than
    -- this become unwalkable barriers.
    --
    -- Docs:
    -- Maximum ledge height that is considered to still be traversable. [Limit: >=0] [Units: vx]
    agentMaxClimb = 0.6,

    -- Maximum length of a single contour edge (in wu). Long edges are split
    -- at this length. 0 = no limit (edges can be any length).
    --
    -- Docs:
    -- The maximum allowed length for contour edges along the border of the mesh. [Limit: >=0] [Units: vx]
    -- Setting maxEdgeLen to zero will disable the edge length feature.
    maxEdgeLen = 0.0,

    -- How aggressively contour corners are simplified. Higher values collapse
    -- more vertices, producing blunter corners that stay further from edges.
    -- Lower values follow the voxelized boundary more precisely.
    --
    -- Docs:
    -- The maximum distance a simplified contour's border edges should deviate
    -- the original raw contour. [Limit: >=0] [Units: vx]
    maxSimplificationError = 1.3,

    -- Isolated walkable patches smaller than this (in voxels squared) are
    -- removed. Eliminates tiny floating islands of navmesh.
    --
    -- Docs:
    -- The minimum number of cells allowed to form isolated island areas. [Limit: >=0] [Units: vx]
    minRegionArea = 8,

    -- Small regions below this size (in voxels squared) are merged into
    -- adjacent larger regions instead of being removed.
    --
    -- Docs:
    -- Any regions with a span count smaller than this value will, if possible,
    -- be merged with larger regions. [Limit: >=0] [Units: vx]
    mergeRegionArea = 20,

    -- Maximum vertices per navmesh polygon. 6 = polygons (detailed),
    -- 3 = triangles only (simpler, chunkier paths).
    --
    -- Docs:
    -- The maximum number of vertices allowed for polygons generated during the
    -- contour to polygon conversion process. [Limit: >= 3]
    maxVertsPerPoly = 6,

    -- How densely the detail mesh samples height data. Higher = more height
    -- samples, smoother surface. 0 = no detail mesh.
    --
    -- Docs:
    -- Sets the sampling distance to use when generating the detail mesh.
    -- (For height detail only.) [Limits: 0 or >= 0.9] [Units: wu]
    detailSampleDist = 6.0,

    -- Maximum allowed height error in the detail mesh. Higher values allow
    -- the detail surface to deviate more from the true height.
    --
    -- Docs:
    -- The maximum distance the detail mesh surface should deviate from heightfield
    -- data. (For height detail only.) [Limit: >=0] [Units: wu]
    detailSampleMaxError = 1.0,

    -- Size of each navmesh tile in voxels. (Memory/speed tradeoffs?)
    -- Larger tiles = fewer tiles but more work per tile.
    -- World size per tile = tileSize * cellSize (64 * 0.5 = 32 wu).
    --
    -- Docs:
    -- The width/height size of tile's on the xz-plane. [Limit: >= 0] [Units: vx]
    tileSize = 64,

    -- Remove walkable spans that have small gaps above them (low ceilings
    -- created by overhanging geometry).
    filterLowHangingObstacles = true,

    -- Remove walkable spans at ledge edges where the drop exceeds agentMaxClimb.
    filterLedgeSpans = true,

    -- Remove walkable spans where the ceiling is lower than agentHeight.
    filterWalkableLowHeightSpans = true,
}

commandObj.onTrigger = function(player)
    local zone = player:getZone()
    if not zone then
        return
    end

    local str = fmt('Rebuilding Navmesh for {}', zone:getName())
    print(str)
    player:printToPlayer(str)

    zone:rebuildNavmesh(config)
end

return commandObj
