-----------------------------------
-- Area: Apollyon NW
--  Mob: Cynoprosopi
-----------------------------------
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Apollyon/IDs")
local flags = tpz.path.flag.NONE
local path =
{
    {-553.732,0.000,599.452},
    {-606.096,0.000,567.105},
    {-577.405,-0.642,541.362},
    {-543.441,0.000,523.866}
}

function onMobRoam(mob)
    if not mob:isFollowingPath() then
        local point = math.random(#path)
        while point == mob:getLocalVar("point") do
            point = math.random(#path)
        end
        mob:setLocalVar("point", point)
        mob:pathTo(path[point][1], path[point][2], path[point][3], flags)
    end
end


function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[4][1]):setPos(mobX, mobY, mobZ)
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[4][1]):setStatus(tpz.status.NORMAL)
    end
end
