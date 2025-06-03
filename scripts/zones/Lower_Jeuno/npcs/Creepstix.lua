-----------------------------------
-- Area: Lower Jeuno
--  NPC: Creepstix
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_GOBLIN_GAVOTTE,   8160 },
        { xi.item.SCROLL_OF_PROTECTRA_II  ,   7074 },
        { xi.item.SCROLL_OF_SHELLRA,          1760 },
        { xi.item.SCROLL_OF_GAIN_VIT,        73740 },
        { xi.item.SCROLL_OF_GAIN_MND,        77500 },
        { xi.item.SCROLL_OF_GAIN_AGI,        85680 },
        { xi.item.SCROLL_OF_GAIN_CHR,        81900 },
        { xi.item.SCROLL_OF_BOOST_VIT,       73740 },
        { xi.item.SCROLL_OF_BOOST_MND,       77500 },
        { xi.item.SCROLL_OF_BOOST_AGI,       85680 },
        { xi.item.SCROLL_OF_BOOST_CHR,       81900 },
        { xi.item.SCROLL_OF_INUNDATION,      73500 },
        { xi.item.SCROLL_OF_ADDLE,          130378 },
    }

    player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.JUNK_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
