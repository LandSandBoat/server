-----------------------------------
-- Area: Dangruf Wadi
--  NPC: qm1
-- Type: spawns Chocoboleech
-- !pos -430 4 115 191
-----------------------------------
local ID = require("scripts/zones/Dangruf_Wadi/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1898) and npcUtil.popFromQM(player, npc, ID.mob.CHOCOBOLEECH, {radius=1}) then -- fresh blood
        player:confirmTrade()

        local positions =
        {
            {-430.330, 4.400, 115.100},
            {-492.926, 4.337,  -7.936},
            { -75.392, 2.531, 293.357},
        }
        local newPosition = npcUtil.pickNewPosition(npc:getID(), positions, true)
        npcUtil.queueMove(npc, newPosition)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.SMALL_HOLE)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
