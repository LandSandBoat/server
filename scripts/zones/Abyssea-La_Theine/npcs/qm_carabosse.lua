-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_carabosse (???)
-- Spawns Carabosse
-- !pos 11 17 148 132
-----------------------------------
<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_carabosse.lua
require('scripts/globals/abyssea')
require('scripts/globals/keyitems')
========
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
require("scripts/globals/status")
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm14.lua
-----------------------------------
local entity = {}

  entity.onTrigger = function(player, npc)
		
  if player:hasKeyItem(xi.ki.SHIMMERING_PIXIE_PINION) and  player:hasKeyItem(xi.ki.PELLUCID_FLY_EYE) then
     player:delKeyItem(xi.ki.SHIMMERING_PIXIE_PINION)
	 player:delKeyItem(xi.ki.PELLUCID_FLY_EYE)
         SpawnMob(17318447):updateClaim(player);
		 
	end
end
<<<<<<<< HEAD:scripts/zones/Abyssea-La_Theine/npcs/qm_carabosse.lua

entity.onTrigger = function(player, npc)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.CARABOSSE_1, { xi.ki.PELLUCID_FLY_EYE, xi.ki.SHIMMERING_PIXIE_PINION })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
========
return entity
>>>>>>>> mods:scripts/zones/Abyssea-La_Theine/npcs/qm14.lua
