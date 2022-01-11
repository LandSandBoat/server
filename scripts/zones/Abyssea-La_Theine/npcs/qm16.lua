-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm16 (???)
-- Spawns Briareus
-- !pos -170 7 269 132
-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)

if player:hasKeyItem(xi.ki.DENTED_GIGAS_SHIELD) and  player:hasKeyItem(xi.ki.WARPED_GIGAS_ARMBAND) and  player:hasKeyItem(xi.ki.SEVERED_GIGAS_COLLAR) then
     player:delKeyItem(xi.ki.DENTED_GIGAS_SHIELD);
	 player:delKeyItem(xi.ki.WARPED_GIGAS_ARMBAND);
	 player:delKeyItem(xi.ki.SEVERED_GIGAS_COLLAR);
     SpawnMob(17318456):updateClaim(player);
	end
end

entity.onTrade = function(player, npc, trade)

if (trade:hasItemQty(2893,1)) then -- Black Tiger Fang
        player:tradeComplete();
        SpawnMob(17821699):updateClaim(player);
	end

end;
return entity