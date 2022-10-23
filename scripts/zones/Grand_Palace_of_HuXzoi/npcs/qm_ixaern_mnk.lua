-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: qm_ixaern_mnk (???)
-- !pos 460 0 540 34
-- !pos 380 0 540 34
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local nm = GetMobByID(ID.mob.IXAERN_MNK)

    if not nm:isSpawned() then
        local chance = 0 -- percent chance that an item will drop.

        if npcUtil.tradeHas(trade, { { xi.items.HIGH_QUALITY_AERN_ORGAN, 3 } }) then
            chance = 100
        elseif npcUtil.tradeHas(trade, { { xi.items.HIGH_QUALITY_AERN_ORGAN, 2 } }) then
            chance = 66
        elseif npcUtil.tradeHas(trade, xi.items.HIGH_QUALITY_AERN_ORGAN) then
            chance = 33
        end

        if chance > 0 then
            player:confirmTrade()
            npc:setLocalVar("[SEA]IxAern_DropRate", chance) -- adjusts drops in IxAern (MNK)'s onMobSpawn.
            npc:setStatus(xi.status.DISAPPEAR)

            -- spawn Ix'Aern (MNK) and minions
            nm:setSpawn(npc:getXPos(), npc:getYPos(), npc:getZPos())
            SpawnMob(ID.mob.IXAERN_MNK):updateClaim(player)
            if chance >= 66 then
                GetMobByID(ID.mob.IXAERN_MNK + 1):setSpawn(npc:getXPos(), npc:getYPos(), npc:getZPos()-4)
                SpawnMob(ID.mob.IXAERN_MNK + 1):updateClaim(player)
            end
            if chance == 100 then
                GetMobByID(ID.mob.IXAERN_MNK + 2):setSpawn(npc:getXPos(), npc:getYPos(), npc:getZPos()+4)
                SpawnMob(ID.mob.IXAERN_MNK + 2):updateClaim(player)
            end

        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
