-----------------------------------
-- Area: Apollyon SE, Floor 3
--  Mob: Inhumer
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/zones/Apollyon/bcnms/se_apollyon_helper")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local flags = xi.path.flag.WALLHACK
local path =
{
    [1] = { { 391.345,  0.000, -362.357 }, { 409.661, -0.500, -372.819 } },
    [2] = { { 334.872,  0.000, -336.313 }, { 341.842, -0.764, -319.744 } },
    [3] = { { 362.613,  0.000, -276.235 }, { 344.407, -1.398, -280.625 } },
    [4] = { { 327.796,  0.000, -320.106 }, { 336.038, -1.286, -310.834 } },
    [5] = { { 326.597,  0.000, -313.956 }, { 322.230, -0.493, -328.462 } },
    [6] = { { 363.584,  0.000, -300.336 }, { 348.563, -1.110, -312.928 } },
    [7] = { { 331.868,  0.000, -337.062 }, { 330.350, -0.481, -323.224 } },
    [8] = { { 340.493, -0.879, -309.115 }, { 339.728, -0.582, -320.195 } }
}

entity.onMobRoam = function(mob)
    local offset = mob:getID() - ID.mob.APOLLYON_SE_MOB[3]
    local pause  = mob:getLocalVar("pause")
    local start  = mob:getLocalVar("start") == 1

    if pause < os.time() and start then
        local point = (mob:getLocalVar("point") % 2) + 1
        mob:setLocalVar("point", point)
        mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
        mob:setLocalVar("pause", os.time() + 30)
    end
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.HTH_SDT, 1500)
    mob:setMod(xi.mod.IMPACT_SDT, 1500)
    mob:setMod(xi.mod.PIERCE_SDT, 0)
end

entity.onMobEngaged = function(mob, target)
    local start = mob:getLocalVar("start") == 1

    if not start then
        for i = 1, 8 do
            GetMobByID(ID.mob.APOLLYON_SE_MOB[3] + i):setLocalVar("pause", os.time() + (3 * i))
            GetMobByID(ID.mob.APOLLYON_SE_MOB[3] + i):setLocalVar("start", 1)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_se.handleMobDeathFloorThree(mob, player, isKiller, noKiller)
end

return entity
