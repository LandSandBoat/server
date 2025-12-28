-----------------------------------
-- Area: Windurst Waters
--  NPC: Hilkomu-Makimu
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_STONE_II,      6645, 3 },
        { xi.item.SCROLL_OF_WATER_II,      9360, 3 },
        { xi.item.SCROLL_OF_AERO_II,      13832, 3 },
        { xi.item.SCROLL_OF_FIRE_II,      19136, 3 },
        { xi.item.SCROLL_OF_BLIZZARD_II,  25272, 3 },
        { xi.item.SCROLL_OF_THUNDER_II,   32240, 3 },
        { xi.item.SCROLL_OF_STONEGA,       1346, 2 },
        { xi.item.SCROLL_OF_WATERGA,       2423, 2 },
        { xi.item.SCROLL_OF_AEROGA,        4792, 2 },
        { xi.item.SCROLL_OF_FIRAGA,        8118, 2 },
        { xi.item.SCROLL_OF_BLIZZAGA,     12376, 2 },
        { xi.item.SCROLL_OF_THUNDAGA,     17472, 2 },
        { xi.item.SCROLL_OF_POISON_II,    26208, 1 },
        { xi.item.SCROLL_OF_BIO_II,       14560, 1 },
        { xi.item.SCROLL_OF_POISONGA,      5366, 1 },
        { xi.item.SCROLL_OF_SHOCK_SPIKES,  9360, 2 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.HIKOMUMAKIMU_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
