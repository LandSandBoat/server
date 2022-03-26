-----------------------------------
-- Area: Apollyon NW, Floor 1
--  Mob: Pluto
-----------------------------------
require("scripts/zones/Apollyon/bcnms/nw_apollyon_helper")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local flags = xi.path.flag.NONE
local path =
{
    { -459.436, 0.000, -16.257 },
    { -458.178, 0.000,  49.511 }
}

entity.onMobRoam = function(mob)
    local pause = mob:getLocalVar("pause")

    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 2) + 1
        mob:setLocalVar("point", point)
        mob:pathTo(path[point][1], path[point][2], path[point][3], flags)
        mob:setLocalVar("pause", os.time() + 30)
    end
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_nw.handleMobDeathFloorOneChest(mob, player, isKiller, noKiller)
end

return entity
