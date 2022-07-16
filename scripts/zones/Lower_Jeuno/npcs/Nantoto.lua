-----------------------------------
-- Area: Lower Jeuno
--  NPC: Hunter (Nantoto)
-----------------------------------
require("scripts/globals/utils")

local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 25679) then
	    player:tradeComplete()
		player:PrintToPlayer("Nantoto: What the HECK happened here? let me take care of that...", 0xD)
		player:addItem(25679)
		player:messageSpecial(ID.text.ITEM_OBTAINED, 25679)
	else
	    player:PrintToPlayer("Nantoto: I don't want this ...", 0xD)
	end
end

entity.onTrigger = function(player, npc)
    player:PrintToPlayer("Nantoto: Got a busted white rarab cap +1? Trade it to me and I'll fix it lickity split.", 0xD)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
