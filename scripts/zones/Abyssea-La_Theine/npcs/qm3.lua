-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm3 (???)
-- Spawns Megantereon
-- !pos -764 -8 121 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
	player:PrintToPlayer("You feel that something will happen if you trade me a Black Tiger Fang", 0xD);
	
end


entity.onTrade = function(player, npc, trade)

    if(trade:hasItemQty(2893,1)) then -- Black Tiger Fang
        player:tradeComplete();
        SpawnMob(17318436):updateClaim(player);
    end

end;
return entity

