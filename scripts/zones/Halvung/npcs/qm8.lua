-----------------------------------
-- Area: Halvung
--  NPC: ??? (Bracelet of verve)
-- Trade Moblin Oil
-----------------------------------
local ID = zones[xi.zone.HALVUNG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.MOBLIN_OIL) and
        not player:hasKeyItem(xi.ki.BRACELET_OF_VERVE)
    then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, xi.ki.BRACELET_OF_VERVE)
    else
        player:messageSpecial(ID.text.DULL_PIECE)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.DULL_PIECE)
end

return entity
