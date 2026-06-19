-----------------------------------
-- Area: Lower Jeuno
--  NPC: Adelflete
-- ERA Custom Crystal Trades
-----------------------------------
require('modules/custom/lua/era_custom_trades')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.customTrades.adelfete(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.TOURMALINE,     1863 },
        { xi.item.SARDONYX,       1863 },
        { xi.item.AMETHYST,       1863 },
        { xi.item.AMBER_STONE,    1863 },
        { xi.item.LAPIS_LAZULI,   1863 },
        { xi.item.CLEAR_TOPAZ,    1863 },
        { xi.item.ONYX,           1863 },
        { xi.item.LIGHT_OPAL,     1863 },
        { xi.item.SILVER_EARRING, 1250 },
        { xi.item.SILVER_RING,    1250 },
    }

    player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.GEMS_BY_KSHAMA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
