-----------------------------------
-- Area: Boneyard Gully
--  Mob: Race Runner
--  ENM: Like the Wind
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local path =
{
    -539, 0, -481,
    -556, 0, -478,
    -581, 0, -475,
    -579, -3, -460,
    -572, 2, -433,
    -545, 1, -440,
    -532, 0, -466
}

function onMobSpawn(mob)
    onMobRoam(mob)
end

function onMobRoamAction(mob)
    tpz.path.patrol(mob, path, tpz.path.flag.REVERSE)
end

entity.onMobRoam = function(mob)
    if not mob:isFollowingPath() then
        mob:pathThrough(tpz.path.first(path))
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
