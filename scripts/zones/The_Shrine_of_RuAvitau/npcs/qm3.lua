-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  NPC: ??? (Spawns Ullikummi)
-- !pos 739 -99 -581 178
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 2388) and npcUtil.popFromQM(player, npc, ID.mob.ULLIKUMMI) then -- Diorite
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
