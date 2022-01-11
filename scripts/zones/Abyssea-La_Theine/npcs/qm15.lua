-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm15 (???)
-- Spawns Hadhayosh
-- !pos 434 24 41 132
-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)

if player:hasKeyItem(xi.ki.MARBLED_MUTTON_CHOP) and  player:hasKeyItem(xi.ki.BLOODIED_SABER_TOOTH) and  player:hasKeyItem(xi.ki.BLOOD_SMEARED_GIGAS_HELM) and  player:hasKeyItem(xi.ki.GLITTERING_PIXIE_CHOKER) then
     player:delKeyItem(xi.ki.MARBLED_MUTTON_CHOP);
	 player:delKeyItem(xi.ki.BLOODIED_SABER_TOOTH);
	 player:delKeyItem(xi.ki.BLOOD_SMEARED_GIGAS_HELM);
	 player:delKeyItem(xi.ki.GLITTERING_PIXIE_CHOKER);
        SpawnMob(17318448):updateClaim(player);
    end

end;
return entity