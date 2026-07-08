-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: ??? (Spawn Iriz Ima(ZNM T2))
-- !pos 253 -23 116 51
-----------------------------------
local ID = zones[xi.zone.WAJAOM_WOODLANDS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.BUNCH_OF_SENORITA_PAMAMAS) and
        npcUtil.popFromQM(player, npc, ID.mob.IRIZ_IMA)
    then
        -- Trade Senorita Pamamas
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.PAMAMA_PEELS)
end

return entity
