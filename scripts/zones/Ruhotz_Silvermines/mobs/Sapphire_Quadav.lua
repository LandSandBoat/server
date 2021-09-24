-----------------------------------
-- Area: Ruhotz Silvermines
--  Mob: Sapphire Quadav
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/pathfind")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

local pathNodes =
{
    -- x, y, z
    -1.388, 1.0, 34.81,
    -30.27, 0.437, 55.10,
    -38.11, 0.980, 36.33,
}

entity.onPath = function(mob)
    xi.path.patrol(mob, pathNodes)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.BENEDICTION, hpp = math.random(40, 60) },
        },
    })

    entity.onPath(mob)
end

entity.onMobRoam = function(mob)
    -- move to start position if not moving
    if not mob:isFollowingPath() then
        mob:pathThrough(xi.path.first(pathNodes))
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
