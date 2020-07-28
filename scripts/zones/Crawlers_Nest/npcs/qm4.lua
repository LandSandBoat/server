-----------------------------------
-- Area: Crawlers' Nest
--  NPC: ??? - Drone Crawler (Spawn area 2)
-- !pos -74.939 -2.606 244.139 197
-----------------------------------
local ID = require("scripts/zones/Crawlers_Nest/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 4529) then -- Rolanberry 881
        player:confirmTrade()
        if math.random(1, 100) > 50 or not npcUtil.popFromQM(player, npc, ID.mob.AWD_GOGGIE - 3, {claim=true, hide=0}) then
            player:messageSpecial(ID.text.NOTHING_SEEMS_TO_HAPPEN)
        end
    end
end

function onTrigger(player, npc)
end
