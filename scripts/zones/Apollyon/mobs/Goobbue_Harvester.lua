-----------------------------------
-- Area: Apollyon NE
--  Mob: Goobbue Harvester
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Apollyon/IDs")
local flags = tpz.path.flag.NONE
local path =
{
    {424.271, 0.000, 22.975},
    {496.692, 0.000, 22.934}
}

function onMobRoam(mob)
    local pause = mob:getLocalVar("pause")
    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 2)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[point][1], path[point][2], path[point][3], flags)
        mob:setLocalVar("pause", os.time()+40)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        local randomF1 = battlefield:getLocalVar("randomF1")
        if randomF1 == 2 or randomF1 == 4 then
            local mobX = mob:getXPos()
            local mobY = mob:getYPos()
            local mobZ = mob:getZPos()
            GetNPCByID(ID.npc.APOLLYON_NE_CRATE[1][1]):setPos(mobX, mobY, mobZ)
            GetNPCByID(ID.npc.APOLLYON_NE_CRATE[1][1]):setStatus(tpz.status.NORMAL)
        elseif randomF1 == 1 or randomF1 == 3 then
            battlefield:setLocalVar("randomF2", ID.mob.APOLLYON_NE_MOB[2]+math.random(0,2))
            tpz.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_NE_PORTAL[1])
        end
    end
end