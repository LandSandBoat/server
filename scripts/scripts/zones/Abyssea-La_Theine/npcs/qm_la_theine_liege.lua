-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_la_theine_liege (???)
-- Spawns La Theine Liege
-- !pos 80 15 199 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
     if(trade:hasItemQty(2897,1)) then -- Transparent Insect Wing
        player:tradeComplete();
        SpawnMob(17318440):updateClaim(player);
    end
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { 2897 })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
