-----------------------------------
-- Area: Apollyon NE
--  Mob: Barometz
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")

function onMobDeath(mob, player, isKiller, noKiller)
    if mob:getID() == ID.mob.APOLLYON_NE_MOB[1]+1 then
        if isKiller or noKiller then
            local battlefield = mob:getBattlefield()
            local randomF1 = battlefield:getLocalVar("randomF1")
            if randomF1 == 1 or randomF1 == 5 then
                local mobX = mob:getXPos()
                local mobY = mob:getYPos()
                local mobZ = mob:getZPos()
                GetNPCByID(ID.npc.APOLLYON_NE_CRATE[1][1]):setPos(mobX, mobY, mobZ)
                GetNPCByID(ID.npc.APOLLYON_NE_CRATE[1][1]):setStatus(tpz.status.NORMAL)
            elseif randomF1 == 2 or randomF1 == 6 then
                battlefield:setLocalVar("randomF2", ID.mob.APOLLYON_NE_MOB[2]+math.random(0,2))
                tpz.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_NE_PORTAL[1])
            end
        end
    end
end
