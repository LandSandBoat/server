-----------------------------------
-- Area: Quicksand Caves
--  NPC: qm2
-- Note: Spawns Tribunus VII-I
-- !pos -49.944 -0.891 -139.485 208
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.ANTICAN_TAG) and
        npcUtil.popFromQM(player, npc, ID.mob.TRIBUNUS_VII_I)
    then
        player:confirmTrade()
    end
end

return entity
