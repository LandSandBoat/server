-----------------------------------
-- Area: Bastok Markets
--  NPC: Olwyn
-- !pos -322.123 -10.319 -169.418 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_EYE_DROPS,  2724, 3 },
        { xi.item.ANTIDOTE,             331, 3 },
        { xi.item.FLASK_OF_ECHO_DROPS,  840, 2 },
        { xi.item.POTION,               955, 2 },
        { xi.item.ETHER,               5025, 1 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.OLWYN_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
