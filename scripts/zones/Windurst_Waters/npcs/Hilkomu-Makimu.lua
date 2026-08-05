-----------------------------------
-- Area: Windurst Waters
--  NPC: Hilkomu-Makimu
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_STONE_II,      6390, 3 },
        { xi.item.SCROLL_OF_WATER_II,      9000, 3 },
        { xi.item.SCROLL_OF_AERO_II,      13300, 3 },
        { xi.item.SCROLL_OF_FIRE_II,      18400, 3 },
        { xi.item.SCROLL_OF_BLIZZARD_II,  24300, 3 },
        { xi.item.SCROLL_OF_THUNDER_II,   31000, 3 },
        { xi.item.SCROLL_OF_STONEGA,       1295, 2 },
        { xi.item.SCROLL_OF_WATERGA,       2330, 2 },
        { xi.item.SCROLL_OF_AEROGA,        4608, 2 },
        { xi.item.SCROLL_OF_FIRAGA,        7806, 2 },
        { xi.item.SCROLL_OF_BLIZZAGA,     11900, 2 },
        { xi.item.SCROLL_OF_THUNDAGA,     16800, 2 },
        { xi.item.SCROLL_OF_POISON_II,    25200, 1 },
        { xi.item.SCROLL_OF_BIO_II,       14000, 1 },
        { xi.item.SCROLL_OF_POISONGA,      5160, 1 },
        { xi.item.SCROLL_OF_SHOCK_SPIKES,  9000, 2 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.HIKOMUMAKIMU_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
