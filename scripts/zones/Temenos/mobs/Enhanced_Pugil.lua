-----------------------------------
-- Area: Temenos W T
--  Mob: Enhanced Pugil
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/limbus")
local ID = require("scripts/zones/Temenos/IDs")

function onMobEngaged(mob, target)
end

function onMobDeath(mob, player, isKiller)
    if isKiller then
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        local mobID = mob:getID()
        local spawn = math.random(3) == 1

        if GetNPCByID(ID.npc.TEMENOS_W_GATE[6]):getAnimation() == tpz.animation.CLOSE_DOOR then
            tpz.limbus.handleDoors(player:getBattlefield(), true, ID.npc.TEMENOS_W_GATE[6])
        end

        if spawn then
            local battlefield = player:getBattlefield()
            for i = 0, 2 do
                if GetNPCByID(ID.npc.TEMENOS_W_CRATE[6]+i):getStatus() == tpz.status.DISAPPEAR then
                    GetNPCByID(ID.npc.TEMENOS_W_CRATE[6]+i):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_W_CRATE[6]+i, player, "crateMaskF6", battlefield:getLocalVar("crateMaskF6"))
                    break
                end
            end
        end
    end
end
