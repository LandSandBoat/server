-----------------------------------
-- Area: Dangruf Wadi
--  NPC: qm1
-- Type: spawns Chocoboleech
-- !pos -430 4 115 191
-----------------------------------
local ID = zones[xi.zone.DANGRUF_WADI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.VIAL_OF_FRESH_BLOOD) and
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

return entity
