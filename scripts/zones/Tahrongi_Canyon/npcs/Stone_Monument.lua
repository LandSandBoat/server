-----------------------------------
-- Area: Tahrongi Canyon
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos -499.189 12.600 373.592 117
-----------------------------------
local ID = require("scripts/zones/Tahrongi_Canyon/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(900)
end

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 571) and npcUtil.giveItem(player, 570) then
        player:confirmTrade()
        player:setCharVar("anExplorer-CurrentTablet", 0x01000)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
