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
        { xi.item.HUME_TUNIC,       315 },
        { xi.item.HUME_VEST,        315 },
        { xi.item.HUME_M_GLOVES,    189 },
        { xi.item.HUME_F_GLOVES,    189 },
        { xi.item.HUME_SLACKS,      273 },
        { xi.item.HUME_PANTS,       273 },
        { xi.item.HUME_M_BOOTS,     189 },
        { xi.item.HUME_F_BOOTS,     189 },
        { xi.item.GALKAN_SURCOAT,   315 },
        { xi.item.GALKAN_BRACERS,   189 },
        { xi.item.GALKAN_BRAGUETTE, 273 },
        { xi.item.GALKAN_SANDALS,   189 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MINES].text.PROUDBEARD_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
