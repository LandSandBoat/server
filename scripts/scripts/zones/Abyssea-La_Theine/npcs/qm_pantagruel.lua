-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_pantagruel (???)
-- Spawns Pantagruel
-- !pos -356 8 163 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
if(trade:hasItemQty(2895,1)) then -- Oversized Sock
        player:tradeComplete();
        SpawnMob(17318438):updateClaim(player);
    end
	end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { 2895 })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
