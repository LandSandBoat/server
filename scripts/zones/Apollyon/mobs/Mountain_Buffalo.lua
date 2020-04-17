-----------------------------------
-- Area: Apollyon NW
--  Mob: Mountain Buffalo
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Apollyon/IDs")
local flags = tpz.path.flag.NONE
local path =
{
    [1] = 
    {
        {-300.606, 0.000, 342.973},
        {-306.000, 0.000, 317.000}
    },
    [3] = 
    {
        {-331.642, 0.000, 219.558},
        {-356.735, 0.000, 239.488}
    },
    [4] = 
    {
        {-346.456, -1.018, 247.719},
        {-334.000, 0.000, 233.000}
    },
    [5] = 
    {
        {-314.122, 0.000, 275.821},
        {-317.276, 0.000, 240.435}
    },
    [6] = 
    {
        {-364.549, 0.000, 231.121},
        {-355.170, 0.000, 265.456}
    },
    [7] = 
    {
        {-310.297, 0.000, 297.337},
        {-324.275, 0.000, 332.532}
    }
}

function onPath(mob)
    mob:setLocalVar("pause", os.time()+5)
end

function onMobRoam(mob)
    local offset = mob:getID() - ID.mob.APOLLYON_NW_MOB[2]
    local pause = mob:getLocalVar("pause")
    if pause < os.time() and offset ~= 2 then
        local point = (mob:getLocalVar("point") % 2)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
        mob:setLocalVar("pause", os.time()+60)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID = mob:getID()
        local battlefield = mob:getBattlefield()
        local randomF2 = battlefield:getLocalVar("randomF2")
        if mobID == randomF2 then
            battlefield:setLocalVar("randomF3", ID.mob.APOLLYON_NW_MOB[3]+math.random(1,8))
            tpz.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_NW_PORTAL[2])
        end
    end
end
