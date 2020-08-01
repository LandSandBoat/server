-----------------------------------
-- Area: Apollyon NW
--  Mob: Apollyon Scavenger
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Apollyon/IDs")
local flags = tpz.path.flag.WALLHACK
local path =
{
    [1] = 
    {
        {-215.100, 0.000, 541.065},
        {-248.738, 0.000, 530.959}
    },
    [2] = 
    {
        {-286.292, 0.000, 510.972},
        {-310.000, 0.000, 485.000}
    },
    [4] = 
    {
        {-333.930, 0.000, 552.100},
        {-298.615, 0.000, 570.278}
    },
    [5] = 
    {
        {-272.770, 0.000, 540.876},
        {-307.652, 0.000, 574.133}
    },
    [6] = 
    {
        {-339.942, -0.321, 546.121},
        {-326.269, 0.000, 520.347}
    },
    [7] = 
    {
        {-307.256, 0.000, 505.708},
        {-337.000, 0.000, 522.000}
    }
}

function onPath(mob)
    if mob:getID() ~= ID.mob.APOLLYON_NW_MOB[3]+4 then
        mob:setLocalVar("pause", os.time()+1)
    end
end

function onMobRoam(mob)
    local offset = mob:getID() - ID.mob.APOLLYON_NW_MOB[3]
    local pause = mob:getLocalVar("pause")
    if pause < os.time() and offset ~= 3 then
        local point = (mob:getLocalVar("point") % 2)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
        if offset == 4 then
            mob:setLocalVar("pause", os.time()+20)
        else
            mob:setLocalVar("pause", os.time()+60)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID = mob:getID()
        local battlefield = mob:getBattlefield()
        local randomF3 = battlefield:getLocalVar("randomF3")
        if mobID == randomF3 then
            battlefield:setLocalVar("randomF4", ID.mob.APOLLYON_NW_MOB[4]+math.random(1,6))
            tpz.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_NW_PORTAL[3])
        end
    end
end
