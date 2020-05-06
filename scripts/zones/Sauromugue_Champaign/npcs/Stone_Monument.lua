-----------------------------------
-- Area: Sauromugue Champaign
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos 77.544 -2.746 -184.803 120
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(900)
end

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 571) and npcUtil.giveItem(player, 570) then
        player:confirmTrade()
        player:setCharVar("anExplorer-CurrentTablet", 0x08000)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
