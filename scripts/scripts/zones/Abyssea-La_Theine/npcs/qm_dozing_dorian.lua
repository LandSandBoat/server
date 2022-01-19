-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_dozing_dorian (???)
-- Spawns Dozing Dorian
-- !pos 703 40 283 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    	if(trade:hasItemQty(2891,1) and trade:getItemCount() == 1) then -- Dried Chigo
		player:tradeComplete();
		SpawnMob(17318434):updateEnmity(player);
	end

end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { 2891 })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
