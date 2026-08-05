-----------------------------------
-- Area: Windurst Woods
--  NPC: Wije Tiren
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_EYE_DROPS,        2595 },
        { xi.item.ANTIDOTE,                   316 },
        { xi.item.FLASK_OF_ECHO_DROPS,        800 },
        { xi.item.POTION,                     910 },
        { xi.item.ETHER,                     4832 },
        { xi.item.SCROLL_OF_HERB_PASTORAL,    108 },
        { xi.item.FLASK_OF_DISTILLED_WATER,    12 },
        { xi.item.FEDERATION_WAYSTONE,      10000 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.WIJETIREN_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
