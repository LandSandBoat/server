-----------------------------------
-- Area: Port Jeuno
--  NPC: Monisette
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/utils")
local ID = require("scripts/zones/Port_Jeuno/IDs")
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (npcUtil.tradeHasExactly(trade, {{ "gil", 250000 }}) and player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)) then
        player:tradeComplete()
		player:addItem(1987)
		player:messageSpecial(ID.text.ITEM_OBTAINED, 1987)
	end	
end

entity.onTrigger = function(player, npc)
    player:PrintToPlayer("Monisette: Looking for a particular chip?... Perhaps one.... charcoal in color?", 0xD)
	player:PrintToPlayer("Monisette: It will cost you, BIG TIME! 250,000 Gil.", 0xD)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity


