-----------------------------------
-- Area: North Gustaberg
--  NPC: Waterfall Base
-- Involved In Quest: Drachenfall
-- !pos -217.594 98.644 464.722 106
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.items.BRASS_CANTEEN) and npcUtil.giveItem(player, xi.items.CANTEEN_OF_DRACHENFALL_WATER) then
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
