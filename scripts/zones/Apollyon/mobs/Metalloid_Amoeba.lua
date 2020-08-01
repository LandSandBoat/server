-----------------------------------
-- Area: Apollyon SE
--  Mob: Metalloid Amoeba
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")

function onMobSpawn(mob)
    mob:setMod(tpz.mod.SLASHRES, 1500)
    mob:setMod(tpz.mod.HTHRES, 0)
    mob:setMod(tpz.mod.IMPACTRES, 0)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        local battlefield = mob:getBattlefield()
        battlefield:setLocalVar("killCountF1", battlefield:getLocalVar("killCountF1")+1)
        local killCount = battlefield:getLocalVar("killCountF1")
        if killCount == 2 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[1]):setPos(mobX, mobY, mobZ)
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[1]):setStatus(tpz.status.NORMAL)
        elseif killCount == 4 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[1]+1):setPos(mobX, mobY, mobZ)
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[1]+1):setStatus(tpz.status.NORMAL)
        elseif killCount == 8 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[1]+2):setPos(mobX, mobY, mobZ)
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[1]+2):setStatus(tpz.status.NORMAL)        
        end
    end
end
