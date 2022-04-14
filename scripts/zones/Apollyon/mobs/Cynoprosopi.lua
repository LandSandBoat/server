-----------------------------------
-- Area: Apollyon NW, Floor 4
--  Mob: Cynoprosopi
-----------------------------------
require("scripts/zones/Apollyon/bcnms/nw_apollyon_helper")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local flags = xi.path.flag.NONE
local path =
{
    { -553.732,  0.000, 599.452 },
    { -606.096,  0.000, 567.105 },
    { -577.405, -0.642, 541.362 },
    { -543.441,  0.000, 523.866 }
}

entity.onMobRoam = function(mob)
    if not mob:isFollowingPath() then
        local point = math.random(#path)

        while point == mob:getLocalVar("point") do
            point = math.random(#path)
        end

        mob:setLocalVar("point", point)
        mob:pathTo(path[point][1], path[point][2], path[point][3], flags)
    end
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_nw.handleMobDeathFloorFourChest(mob, player, isKiller, noKiller)
end

return entity
