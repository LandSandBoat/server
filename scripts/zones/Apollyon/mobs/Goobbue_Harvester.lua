-----------------------------------
-- Area: Apollyon NE, Floor 1
--  Mob: Goobbue Harvester
-----------------------------------
require("scripts/zones/Apollyon/helpers/apollyon_ne")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local flags = xi.path.flag.NONE
local path =
{
    {424.271, 0.000, 22.975},
    {496.692, 0.000, 22.934}
}

entity.onMobRoam = function(mob)
    local pause = mob:getLocalVar("pause")

    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 2) + 1
        mob:setLocalVar("point", point)
        mob:pathTo(path[point][1], path[point][2], path[point][3], flags)
        mob:setLocalVar("pause", os.time() + 40)
    end
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_ne.handleMobDeathFloorOne(mob, player, isKiller, noKiller)
end

return entity
