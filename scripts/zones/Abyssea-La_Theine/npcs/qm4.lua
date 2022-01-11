-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm4 (???)
-- Spawns Adamastor
-- !pos -716 15 639 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Trophy Shield", 0xD);
	
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2894,1)) then -- Trophy Shield
        player:tradeComplete();
        SpawnMob(17318437):updateClaim(player);
    end

end

return entity