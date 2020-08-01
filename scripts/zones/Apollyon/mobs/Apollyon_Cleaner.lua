-----------------------------------
-- Area: Apollyon NE
--  Mob: Apollyon Cleaner
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID = mob:getID()
        local battlefield = mob:getBattlefield()
        local itemF3 = battlefield:getLocalVar("itemF3")
        if itemF3 == mobID then
            local mobX = mob:getXPos()
            local mobY = mob:getYPos()
            local mobZ = mob:getZPos()
            GetNPCByID(ID.npc.APOLLYON_NE_CRATE[3][1]):setPos(mobX, mobY, mobZ)
            GetNPCByID(ID.npc.APOLLYON_NE_CRATE[3][1]):setStatus(tpz.status.NORMAL)
        end
    end
end
