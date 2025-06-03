-----------------------------------
-- Area: Halvung
--  NPC: ??? (Spawn Reacton(ZNM T2))
-- !pos 18 -9 213 62
-----------------------------------
local ID = zones[xi.zone.HALVUNG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.LUMP_OF_BONE_CHARCOAL) and
        npcUtil.popFromQM(player, npc, ID.mob.REACTON)
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.THIN_LAYER_OF_CINDER)
end

return entity
