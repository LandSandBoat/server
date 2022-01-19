-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_grandgousier (???)
-- Spawns Grandgousier
-- !pos -398 .010 -322 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
 if(trade:hasItemQty(2896,1)) then -- Massive Armband
        player:tradeComplete();
        SpawnMob(17318439):updateClaim(player);
    end
	end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { 2896 })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
