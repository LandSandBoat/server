-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_briareus (???)
-- Spawns Briareus
-- !pos -179 7 259 132
-----------------------------------
<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_briareus.lua
require('scripts/globals/abyssea')
require('scripts/globals/keyitems')
========
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm13.lua
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_briareus.lua
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.BRIAREUS_1, { xi.ki.DENTED_GIGAS_SHIELD, xi.ki.WARPED_GIGAS_ARMBAND, xi.ki.SEVERED_GIGAS_COLLAR })
end
========
  if player:hasKeyItem(xi.ki.DENTED_GIGAS_SHIELD) and  player:hasKeyItem(xi.ki.WARPED_GIGAS_ARMBAND) and  player:hasKeyItem(xi.ki.SEVERED_GIGAS_COLLAR) then
     player:delKeyItem(xi.ki.DENTED_GIGAS_SHIELD)
	 player:delKeyItem(xi.ki.WARPED_GIGAS_ARMBAND)
	 player:delKeyItem(xi.ki.SEVERED_GIGAS_COLLAR)
     SpawnMob(17318446):updateClaim(player);
	
	 
  end
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm13.lua

end;
return entity