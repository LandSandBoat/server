-----------------------------------
-- Area: Bastok Mines
--  NPC: Proud Beard
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.HUME_TUNIC,       312,
        xi.item.HUME_VEST,        312,
        xi.item.HUME_M_GLOVES,    187,
        xi.item.HUME_F_GLOVES,    187,
        xi.item.HUME_SLACKS,      270,
        xi.item.HUME_PANTS,       270,
        xi.item.HUME_M_BOOTS,     187,
        xi.item.HUME_F_BOOTS,     187,
        xi.item.GALKAN_SURCOAT,   312,
        xi.item.GALKAN_BRACERS,   187,
        xi.item.GALKAN_BRAGUETTE, 270,
        xi.item.GALKAN_SANDALS,   187,
    }

    player:showText(npc, ID.text.PROUDBEARD_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
