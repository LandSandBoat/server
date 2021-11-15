-----------------------------------
-- Zone: Abyssea - Attohwa
--  NPC: Atma Fabricant
-----------------------------------
require("scripts/globals/abyssea/atma_fabricant")
-----------------------------------

local entity = {}

entity.onTrade = function(player,npc,trade)
    xi.atmaFabricant.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
	xi.atmaFabricant.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
	xi.atmaFabricant.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
	xi.atmaFabricant.onEventFinish(player, csid, option)
end

return entity
