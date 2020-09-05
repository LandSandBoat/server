-----------------------------------
-- Area: Apollyon NW
--  Mob: Bardha
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Apollyon/IDs")
local flags = tpz.path.flag.NONE
local path =
{
    [1] = 
    {
        {-390.498, -0.005, 64.145},
        {-407.565, 0.000, 45.689}
    },
    [2] = 
    {
        {-408.219, 0.000, 70.898},
        {-398.421, 0.000, 39.880}
    },
    [3] = 
    {
        {-434.176, 0.000, 20.696},
        {-456.388, -0.133, 22.150}
    },
    [4] = 
    {
        {-511.497, 0.000, 35.424},
        {-480.833, 0.000, 24.301}
    },
    [5] = 
    {
        {-446.345, 0.000, 23.886},
        {-421.125, 0.000, 22.351}
    },
    [6] = 
    {
        {-477.721, 0.000, -24.792},
        {-428.766, 0.000, -26.896}
    },
    [7] = 
    {
        {-413.615, 0.000, 29.428},
        {-445.956, 0.000, 47.672}
    }
}

function onPath(mob)
    mob:setLocalVar("pause", os.time()+1)
end

function onMobRoam(mob)
    local offset = mob:getID() - ID.mob.APOLLYON_NW_MOB[1]
    local pause = mob:getLocalVar("pause")
    if pause < os.time() then
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
        local randomF1 = battlefield:getLocalVar("randomF1")
        if mobID == randomF1 then
            battlefield:setLocalVar("randomF2", ID.mob.APOLLYON_NW_MOB[2]+math.random(1,8))
            tpz.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_NW_PORTAL[1])
        end
    end
end
