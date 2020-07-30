-----------------------------------
-- Area: West Sarutabaruta
--  NPC: Stone Monument
-- Note: Involved in quest "An Explorer's Footsteps"
-- !pos -205.593 -23.210 -119.670 115
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(900)
end

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 571) and npcUtil.giveItem(player, 570) then
        player:confirmTrade()
        player:setCharVar("anExplorer-CurrentTablet", 0x00400)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
