-----------------------------------
-- Area: Mamook
--  NPC: ??? (Spawn Iriri Samariri(ZNM T2))
-- !pos -118 7 -80 65
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.STRAND_OF_SAMARIRI_CORPSEHAIR) and
        npcUtil.popFromQM(player, npc, ID.mob.IRIRI_SAMARIRI)
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

return entity
