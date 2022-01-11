-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm12 (???)
-- Spawns Lugarhoo
-- !pos -85 24 -513 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Filthy Gnole Claw", 0xD);
	
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2902,1)) then -- Filthy Gnole Claw    
        player:tradeComplete();
        SpawnMob(17318445):updateClaim(player);
    end

end;
return entity