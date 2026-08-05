-----------------------------------
-- Area: Selbina
--  NPC: Chutarmire
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_STONE_II,      6390 },
        { xi.item.SCROLL_OF_WATER_II,      9000 },
        { xi.item.SCROLL_OF_AERO_II,      13300 },
        { xi.item.SCROLL_OF_FIRE_II,      18400 },
        { xi.item.SCROLL_OF_BLIZZARD_II,  24300 },
        { xi.item.SCROLL_OF_THUNDER_II,   31000 },
        { xi.item.SCROLL_OF_STONEGA,       1295 },
        { xi.item.SCROLL_OF_WATERGA,       2330 },
        { xi.item.SCROLL_OF_AEROGA,        4608 },
        { xi.item.SCROLL_OF_FIRAGA,        7806 },
        { xi.item.SCROLL_OF_BLIZZAGA,     11900 },
        { xi.item.SCROLL_OF_THUNDAGA,     16800 },
        { xi.item.SCROLL_OF_POISON_II,    25200 },
        { xi.item.SCROLL_OF_BIO_II,       14000 },
        { xi.item.SCROLL_OF_POISONGA,      5160 },
        { xi.item.SCROLL_OF_SHOCK_SPIKES,  9000 },
    }

    player:showText(npc, zones[xi.zone.SELBINA].text.CHUTARMIRE_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.SELBINA_RABAO)
end

return entity
