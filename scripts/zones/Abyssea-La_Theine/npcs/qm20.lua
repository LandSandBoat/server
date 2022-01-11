-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm20 (???)
-- Spawns Carabosse
-- !pos 26 19 148 132
-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
		
  if player:hasKeyItem(xi.ki.SHIMMERING_PIXIE_PINION) and  player:hasKeyItem(xi.ki.PELLUCID_FLY_EYE) then
     player:delKeyItem(xi.ki.SHIMMERING_PIXIE_PINION)
	 player:delKeyItem(xi.ki.PELLUCID_FLY_EYE)
        SpawnMob(17318460):updateClaim(player);
    end
end
return entity