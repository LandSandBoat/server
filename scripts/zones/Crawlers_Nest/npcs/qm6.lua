-----------------------------------
-- Area: Crawlers Nest
--  NPC: ??? - Matron Crawler spawn
-- !pos -141.158 -33.689 20.944 197
-----------------------------------
local ID = require("scripts/zones/Crawlers_Nest/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 4530) then -- Rolanberry 874
        player:confirmTrade()
        if math.random(1, 100) > 34 or not npcUtil.popFromQM(player, npc, ID.mob.AWD_GOGGIE - 1, {claim=true, hide=0}) then
            player:messageSpecial(ID.text.NOTHING_SEEMS_TO_HAPPEN)
        end
    end
end

function onTrigger(player, npc)
end
