-----------------------------------
-- Area: Ruhotz Silvermines
--  Mob: Sapphire Quadav
-----------------------------------
require("scripts/globals/pathfind")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -1.388, y = 1.0, z = 34.81 },
    { x = -30.27, y = 0.437, z = 55.10 },
    { x = -38.11, y = 0.980, z = 36.33 },
}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.BENEDICTION, hpp = math.random(40, 60) },
        },
    })

    mob:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
