-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm19 (???)
-- Spawns Briareus
-- !pos -189 7 269 132
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
     SpawnMob(17318459):updateClaim(player)
     end
end
return entity