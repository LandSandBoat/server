-----------------------------------
-- Area: Kazham
--  NPC: Pahya Lolohoiv
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_DISTILLED_WATER,   12 },
        { xi.item.FLASK_OF_EYE_DROPS,       2595 },
        { xi.item.ANTIDOTE,                  316 },
        { xi.item.FLASK_OF_ECHO_DROPS,       800 },
        { xi.item.POTION,                    910 },
        { xi.item.ETHER,                    4832 },
        { xi.item.VIAL_OF_FIEND_BLOOD,       605 },
        { xi.item.PINCH_OF_POISON_DUST,      320 },
    }

    player:showText(npc, zones[xi.zone.KAZHAM].text.PAHYALOLOHOIV_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
