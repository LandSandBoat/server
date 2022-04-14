-----------------------------------
-- Area: Apollyon NW, Floor 2
--  Mob: Mountain Buffalo
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/zones/Apollyon/bcnms/nw_apollyon_helper")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local flags = xi.path.flag.NONE
local path =
{
    [1] = { { -300.606,  0.000, 342.973 }, { -306.000, 0.000, 317.000 } },
    [3] = { { -331.642,  0.000, 219.558 }, { -356.735, 0.000, 239.488 } },
    [4] = { { -346.456, -1.018, 247.719 }, { -334.000, 0.000, 233.000 } },
    [5] = { { -314.122,  0.000, 275.821 }, { -317.276, 0.000, 240.435 } },
    [6] = { { -364.549,  0.000, 231.121 }, { -355.170, 0.000, 265.456 } },
    [7] = { { -310.297,  0.000, 297.337 }, { -324.275, 0.000, 332.532 } }
}

entity.onPath = function(mob)
    mob:setLocalVar("pause", os.time()+5)
end

entity.onMobRoam = function(mob)
    local offset = mob:getID() - ID.mob.APOLLYON_NW_MOB[2]
    local pause = mob:getLocalVar("pause")

    if pause < os.time() and offset ~= 2 then
        local point = (mob:getLocalVar("point") % 2) + 1
        mob:setLocalVar("point", point)
        mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
        mob:setLocalVar("pause", os.time() + 60)
    end
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_nw.handleMobDeathFloorTwoPortal(mob, player, isKiller, noKiller)
end

return entity
