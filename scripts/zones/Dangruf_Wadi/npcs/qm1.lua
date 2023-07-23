-----------------------------------
-- Area: Dangruf Wadi
--  NPC: qm1
-- Type: spawns Chocoboleech
-- !pos -430 4 115 191
-----------------------------------
local ID = require("scripts/zones/Dangruf_Wadi/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.items.VIAL_OF_FRESH_BLOOD) and
        npcUtil.popFromQM(player, npc, ID.mob.CHOCOBOLEECH, { radius = 1 })
    then
        player:confirmTrade()

        local positions =
        {
            { -430.330, 4.400, 115.100 },
            { -492.926, 4.337,  -7.936 },
            {  -75.392, 2.531, 293.357 },
        }
        local newPosition = npcUtil.pickNewPosition(npc:getID(), positions, true)
        npcUtil.queueMove(npc, newPosition)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SMALL_HOLE)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
