-----------------------------------
-- Area: Crawlers' Nest
--  NPC: ??? - Guardian Crawler (Spawn area 1)
-- !pos 124.335 -34.609 -75.373 197
-----------------------------------
local ID = require("scripts/zones/Crawlers_Nest/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 4365) then -- Rolanberry
        player:confirmTrade()
        if math.random(1, 100) > 38 or not npcUtil.popFromQM(player, npc, ID.mob.AWD_GOGGIE - 6, {claim=true, hide=0}) then
            player:messageSpecial(ID.text.NOTHING_SEEMS_TO_HAPPEN)
        end
    end
end

function onTrigger(player, npc)
end
