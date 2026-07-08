-----------------------------------
-- Area: Norg
--  NPC: Solby-Maholby
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LUGWORM,                      9 },
        { xi.item.EARTH_SPIRIT_PACT,          450 },
        { xi.item.NORG_WAYSTONE,             9000 },
        { xi.item.SCROLL_OF_AISHA_ICHI,     92610 },
        { xi.item.SCROLL_OF_MYOSHU_ICHI,    98894 },
        { xi.item.SCROLL_OF_YURIN_ICHI,     95754 },
        { xi.item.SCROLL_OF_MIGAWARI_ICHI, 155232 },
        { xi.item.SCROLL_OF_GEKKA_ICHI,    163705 },
        { xi.item.SCROLL_OF_YAIN_ICHI,     163705 },
        { xi.item.SCROLL_OF_KATON_SAN,     125212 },
        { xi.item.SCROLL_OF_HYOTON_SAN,    125212 },
        { xi.item.SCROLL_OF_HUTON_SAN,     125212 },
        { xi.item.SCROLL_OF_DOTON_SAN,     125212 },
        { xi.item.SCROLL_OF_RAITON_SAN,    125212 },
        { xi.item.SCROLL_OF_SUITON_SAN,    125212 },
    }

    player:showText(npc, zones[xi.zone.NORG].text.SOLBYMAHOLBY_SHOP_DIALOG, 0, 0, 0, 0, true, false)
    xi.shop.general(player, stock)
end

return entity
