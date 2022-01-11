-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm5 (???)
-- Spawns Pantagruel
-- !pos -356 8 163 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Oversized Sock", 0xD);
	
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2895,1)) then -- Oversized Sock
        player:tradeComplete();
        SpawnMob(17318438):updateClaim(player);
    end

end;
return entity