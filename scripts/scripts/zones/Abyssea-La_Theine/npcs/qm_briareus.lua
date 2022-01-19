-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_briareus (???)
-- Spawns Briareus
-- !pos -179 7 259 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
   if player:hasKeyItem(xi.ki.DENTED_GIGAS_SHIELD) and  player:hasKeyItem(xi.ki.WARPED_GIGAS_ARMBAND) and  player:hasKeyItem(xi.ki.SEVERED_GIGAS_COLLAR) then
     player:delKeyItem(xi.ki.DENTED_GIGAS_SHIELD);
	 player:delKeyItem(xi.ki.WARPED_GIGAS_ARMBAND);
	 player:delKeyItem(xi.ki.SEVERED_GIGAS_COLLAR);
     SpawnMob(17318446):updateClaim(player)
	else
	player:PrintToPlayer("I need a DENTED GIGAS SHIELD, WARPED GIGAS ARMBAND and SEVERED GIGAS COLLAR.", 0xD);
	end
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
