-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm9 (???)
-- Spawns Nguruvilu
-- !pos 311 23 -524 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}


entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Winter Puk Egg", 0xD);
	
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2899,1)) then -- Winter Puk Egg
        player:tradeComplete();
        SpawnMob(17318442):updateEnmity(player);
    end

end;
return entity
