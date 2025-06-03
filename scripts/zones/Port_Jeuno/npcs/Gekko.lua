-----------------------------------
-- Area: Port Jeuno
--  NPC: Gekko
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_EYE_DROPS,                2595 },
        { xi.item.ANTIDOTE,                           316 },
        { xi.item.FLASK_OF_ECHO_DROPS,                800 },
        { xi.item.POTION,                             910 },
        { xi.item.ETHER,                             4832 },
        { xi.item.ROLANBERRY,                         120 },
        { xi.item.SCROLL_OF_REGEN_IV,               50400 },
        { xi.item.COPY_OF_AUTUMNS_END_IN_GUSTABERG, 36000 },
        { xi.item.COPY_OF_ACOLYTES_GRIEF,           31224 },
    }

    player:showText(npc, zones[xi.zone.PORT_JEUNO].text.DUTY_FREE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
