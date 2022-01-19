-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_lugarhoo (???)
-- Spawns Lugarhoo
-- !pos -85 24 -513 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
 if(trade:hasItemQty(2902,1)) then -- Filthy Gnole Claw    
        player:tradeComplete();
        SpawnMob(17318445):updateClaim(player);
    end
	end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { 2902 })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
