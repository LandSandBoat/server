-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm6 (???)
-- Spawns Grandgousier
-- !pos -398 .010 -322 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Massive Armband", 0xD);
	
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2896,1)) then -- Massive Armband
        player:tradeComplete();
        SpawnMob(17318439):updateClaim(player);
    end

end;
return entity
