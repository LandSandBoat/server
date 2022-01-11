-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm2 (???)
-- Spawns Trudging Thomas
-- !pos 278 24 -82 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Mutton Chop", 0xD);
	
end




entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2892,1)) then -- Mutton Chop
        player:tradeComplete();
        SpawnMob(17318435):updateClaim(player);
    end

end;
return entity
