-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm10 (???)
-- Spawns Poroggo Dom Juan
-- !pos 405.785 26.404 -543.056 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Bug-eaten Hat", 0xD);
	
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2900,1)) then -- Bug-eaten Hat
        player:tradeComplete();
        SpawnMob(17318443):updateClaim(player);
    end

end;
return entity
