-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm1 (???)
-- Spawns Dozing Dorian
-- !pos 703 40 283 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Dried Chigo", 0xD);
	
end



entity.onTrade = function(player, npc, trade)
	
	if(trade:hasItemQty(2891,1) and trade:getItemCount() == 1) then -- Dried Chigo
		player:tradeComplete();
		SpawnMob(17318434):updateEnmity(player);
	end
	
end;
return entity