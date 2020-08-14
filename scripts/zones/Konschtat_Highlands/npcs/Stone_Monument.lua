-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos -102.355 7.981 253.706 108
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(900)
end

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 571) and npcUtil.giveItem(player, 570) then
        player:confirmTrade()
        player:setCharVar("anExplorer-CurrentTablet", 0x00080)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
