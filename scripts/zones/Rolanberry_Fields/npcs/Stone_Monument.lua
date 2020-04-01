-----------------------------------
-- Area: Rolanberry Fields
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos 362.479 -34.894 -398.994 110
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(900)
end

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 571) and npcUtil.giveItem(player, 570) then
        player:confirmTrade()
        player:setCharVar("anExplorer-CurrentTablet", 0x00200)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
