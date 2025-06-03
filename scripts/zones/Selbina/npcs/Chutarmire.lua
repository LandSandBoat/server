-----------------------------------
-- Area: Selbina
--  NPC: Chutarmire
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_STONE_II,      6645 },
        { xi.item.SCROLL_OF_WATER_II,      9360 },
        { xi.item.SCROLL_OF_AERO_II,      13832 },
        { xi.item.SCROLL_OF_FIRE_II,      19136 },
        { xi.item.SCROLL_OF_BLIZZARD_II,  25272 },
        { xi.item.SCROLL_OF_THUNDER_II,   32240 },
        { xi.item.SCROLL_OF_STONEGA,       1346 },
        { xi.item.SCROLL_OF_WATERGA,       2423 },
        { xi.item.SCROLL_OF_AEROGA,        4792 },
        { xi.item.SCROLL_OF_FIRAGA,        8118 },
        { xi.item.SCROLL_OF_BLIZZAGA,     12376 },
        { xi.item.SCROLL_OF_THUNDAGA,     17472 },
        { xi.item.SCROLL_OF_POISON_II,    26208 },
        { xi.item.SCROLL_OF_BIO_II,       14560 },
        { xi.item.SCROLL_OF_POISONGA,      5366 },
        { xi.item.SCROLL_OF_SHOCK_SPIKES,  9360 },
    }

    player:showText(npc, zones[xi.zone.SELBINA].text.CHUTARMIRE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
