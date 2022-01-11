-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm13 (???)
-- Spawns Briareus
-- !pos -179 7 259 132
-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
  if player:hasKeyItem(xi.ki.DENTED_GIGAS_SHIELD) and  player:hasKeyItem(xi.ki.WARPED_GIGAS_ARMBAND) and  player:hasKeyItem(xi.ki.SEVERED_GIGAS_COLLAR) then
     player:delKeyItem(xi.ki.DENTED_GIGAS_SHIELD)
	 player:delKeyItem(xi.ki.WARPED_GIGAS_ARMBAND)
	 player:delKeyItem(xi.ki.SEVERED_GIGAS_COLLAR)
     SpawnMob(17318446):updateClaim(player);
	
	 
  end

end;
return entity