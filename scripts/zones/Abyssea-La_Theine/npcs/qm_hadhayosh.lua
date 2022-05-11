-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_hadhayosh (???)
-- Spawns Hadhayosh
-- !pos 434 24 41 132
-----------------------------------
<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_hadhayosh.lua
require('scripts/globals/abyssea')
require('scripts/globals/keyitems')
========
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
require("scripts/globals/status")
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm15.lua
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_hadhayosh.lua
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.HADHAYOSH_1, { xi.ki.MARBLED_MUTTON_CHOP, xi.ki.BLOODIED_SABER_TOOTH, xi.ki.GLITTERING_PIXIE_CHOKER, xi.ki.BLOOD_SMEARED_GIGAS_HELM })
end
========
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm15.lua

if player:hasKeyItem(xi.ki.MARBLED_MUTTON_CHOP) and  player:hasKeyItem(xi.ki.BLOODIED_SABER_TOOTH) and  player:hasKeyItem(xi.ki.BLOOD_SMEARED_GIGAS_HELM) and  player:hasKeyItem(xi.ki.GLITTERING_PIXIE_CHOKER) then
     player:delKeyItem(xi.ki.MARBLED_MUTTON_CHOP);
	 player:delKeyItem(xi.ki.BLOODIED_SABER_TOOTH);
	 player:delKeyItem(xi.ki.BLOOD_SMEARED_GIGAS_HELM);
	 player:delKeyItem(xi.ki.GLITTERING_PIXIE_CHOKER);
        SpawnMob(17318448):updateClaim(player);
    end

end;
return entity