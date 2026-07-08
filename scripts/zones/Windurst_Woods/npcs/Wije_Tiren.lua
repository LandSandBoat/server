-----------------------------------
-- Area: Windurst Woods
--  NPC: Wije Tiren
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_EYE_DROPS,        2698 },
        { xi.item.ANTIDOTE,                   328 },
        { xi.item.FLASK_OF_ECHO_DROPS,        832 },
        { xi.item.POTION,                     946 },
        { xi.item.ETHER,                     5025 },
        { xi.item.SCROLL_OF_HERB_PASTORAL,    112 },
        { xi.item.FLASK_OF_DISTILLED_WATER,    12 },
        { xi.item.FEDERATION_WAYSTONE,      10400 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.WIJETIREN_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
