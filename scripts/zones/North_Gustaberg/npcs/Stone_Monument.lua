-----------------------------------
-- Area: North Gustaberg
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos -199.635 96.106 505.624 106
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 571) and npcUtil.giveItem(player, 570) then
        player:confirmTrade()
        player:setCharVar("anExplorer-CurrentTablet", 0x00020)
    end
end

function onTrigger(player, npc)
    player:startEvent(900)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
