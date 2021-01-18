-----------------------------------
-- Area: North Gustaberg
--  NPC: Waterfall Base
-- Involved In Quest: Drachenfall
-- !pos -217.594 98.644 464.722 106
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 493) and npcUtil.giveItem(player, 492) then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.REACH_WATER_FROM_HERE)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
