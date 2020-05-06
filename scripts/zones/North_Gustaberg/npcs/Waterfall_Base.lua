-----------------------------------
-- Area: North Gustaberg
--  NPC: Waterfall Base
-- Involved In Quest: Drachenfall
-- !pos -217.594 98.644 464.722 106
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 493) and npcUtil.giveItem(player, 492) then
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.REACH_WATER_FROM_HERE)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
