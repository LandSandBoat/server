-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm11 (???)
-- Spawns Toppling Tuber
-- !pos -325 38 201 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Giant Agaricus  ", 0xD);
	
end

entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2901,1)) then -- Giant Agaricus  
        player:tradeComplete();
        SpawnMob(17318444):updateClaim(player);
    end

end;
return entity