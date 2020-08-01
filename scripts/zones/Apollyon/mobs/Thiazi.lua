-----------------------------------
-- Area: Apollyon NE
--  Mob: Thiazi
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID = mob:getID()
        local battlefield = mob:getBattlefield()
        local randomF2 = battlefield:getLocalVar("randomF2")
        if randomF2 == mobID then
            local mobX = mob:getXPos()
            local mobY = mob:getYPos()
            local mobZ = mob:getZPos()
            GetNPCByID(ID.npc.APOLLYON_NE_CRATE[2][1]):setPos(mobX, mobY, mobZ)
            GetNPCByID(ID.npc.APOLLYON_NE_CRATE[2][1]):setStatus(tpz.status.NORMAL)
        elseif randomF2+1 == mobID then
            battlefield:setLocalVar("portalTriggerF3", ID.mob.APOLLYON_NE_MOB[3])
            battlefield:setLocalVar("itemF3", ID.mob.APOLLYON_NE_MOB[3]+math.random(1,4))
            local players = battlefield:getPlayers()
            if #players > 6 then
                for i = 5, 9 do
                    GetMobByID(ID.mob.APOLLYON_NE_MOB[3]+i):spawn()
                end
                battlefield:setLocalVar("portalTriggerF3", ID.mob.APOLLYON_NE_MOB[3]+(math.random(0,1)*5))
                battlefield:setLocalVar("itemF3", ID.mob.APOLLYON_NE_MOB[3]+math.random(1,4)+(math.random(0,1)*5))
            end
            if #players > 12 then
                for i = 10, 14 do
                    GetMobByID(ID.mob.APOLLYON_NE_MOB[3]+i):spawn()
                end
                battlefield:setLocalVar("portalTriggerF3", ID.mob.APOLLYON_NE_MOB[3]+(math.random(0,2)*5))
                battlefield:setLocalVar("itemF3", ID.mob.APOLLYON_NE_MOB[3]+math.random(1,4)+(math.random(0,2)*5))
            end
            tpz.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_NE_PORTAL[2])
        end
    end
end
