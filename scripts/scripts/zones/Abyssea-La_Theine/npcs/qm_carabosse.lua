-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_carabosse (???)
-- Spawns Carabosse
-- !pos 11 17 148 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.SHIMMERING_PIXIE_PINION) and  player:hasKeyItem(xi.ki.PELLUCID_FLY_EYE) then
     player:delKeyItem(xi.ki.SHIMMERING_PIXIE_PINION)
	 player:delKeyItem(xi.ki.PELLUCID_FLY_EYE)
	 SpawnMob(17318457):updateClaim(player)
    else
	player:PrintToPlayer("I need a SHIMMERING PIXIE PINION and PELLUCID FLY EYE.", 0xD);	
	end
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
