-----------------------------------
-- Area: Bastok Mines
--  NPC: Proud Beard
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.HUME_TUNIC,       270 },
        { xi.item.HUME_VEST,        270 },
        { xi.item.HUME_M_GLOVES,    162 },
        { xi.item.HUME_F_GLOVES,    162 },
        { xi.item.HUME_SLACKS,      234 },
        { xi.item.HUME_PANTS,       234 },
        { xi.item.HUME_M_BOOTS,     162 },
        { xi.item.HUME_F_BOOTS,     162 },
        { xi.item.GALKAN_SURCOAT,   270 },
        { xi.item.GALKAN_BRACERS,   162 },
        { xi.item.GALKAN_BRAGUETTE, 234 },
        { xi.item.GALKAN_SANDALS,   162 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MINES].text.PROUDBEARD_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
