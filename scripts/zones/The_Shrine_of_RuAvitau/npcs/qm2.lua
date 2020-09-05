-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  NPC: ??? (Spawns Kirin)
-- !pos -81 32 2 178
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, {1404, 1405, 1406, 1407}) and npcUtil.popFromQM(player, npc, ID.mob.KIRIN) then
        player:showText(npc, ID.text.KIRIN_OFFSET)
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:startEvent(100)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
