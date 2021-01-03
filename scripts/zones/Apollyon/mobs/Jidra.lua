-----------------------------------
-- Area: Apollyon SW
--  Mob: Jidra
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID = mob:getID()
        if mobID == ID.mob.APOLLYON_SW_MOB[2] then
            local battlefield = mob:getBattlefield()
            local players = battlefield:getPlayers()
            for i, member in pairs(players) do
                member:messageSpecial(ID.text.GATE_OPEN)
                member:messageSpecial(ID.text.TIME_LEFT, battlefield:getRemainingTime()/60)
            end
            GetNPCByID(ID.npc.APOLLYON_SW_PORTAL[2]):setAnimation(8)
        else
            local mobX = mob:getXPos()
            local mobY = mob:getYPos()
            local mobZ = mob:getZPos()
            local add_mob = GetMobByID(mobID + 7)
            add_mob:setPos(mobX, mobY, mobZ)
            add_mob:setSpawn(mobX, mobY, mobZ)
            add_mob:spawn()
            if player then
                add_mob:updateEnmity(player)
            end
        end
    end
end
