-----------------------------------
-- Area: Oldton_Movalpolos
--  NPC: Scrawled_Writing
-- Allows players to spawn NM Goblin Wolfman
-----------------------------------
local ID = zones[xi.zone.OLDTON_MOVALPOLOS]
-----------------------------------
---@type TNpcEntity
local entity = {}

local scrawledWritingPositions =
{
    [1] = { -16.806, 7.718, 14.155 },
    [2] = {   -18.0,  12.0, -115.0 },
    [3] = {  -150.0,   8.0, -252.0 },
}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.BOTTLE_OF_GOBLIN_DRINK) and
        npcUtil.popFromQM(player, npc, ID.mob.GOBLIN_WOLFMAN, { radius = 2, hide = 900 })
    then
        player:confirmTrade()
        local newPosition = npcUtil.pickNewPosition(npc:getID(), scrawledWritingPositions, true)
        npcUtil.queueMove(npc, newPosition)
    end
end

return entity
