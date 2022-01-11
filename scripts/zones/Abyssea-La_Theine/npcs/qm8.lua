-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm8 (???)
-- Spawns Baba Yaga
-- !pos -74 18 137 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Piceous Scale", 0xD);
	
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2898,1)) then -- Piceous Scale
        player:tradeComplete();
        SpawnMob(17318441):updateClaim(player);
    end

end;
return entity
