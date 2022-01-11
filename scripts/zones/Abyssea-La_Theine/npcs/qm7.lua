-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm7 (???)
-- Spawns La Theine Liege
-- !pos 80 15 199 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Transparent Insect Wing", 0xD);
	
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2897,1)) then -- Transparent Insect Wing
        player:tradeComplete();
        SpawnMob(17318440):updateClaim(player);
    end

end;
return entity