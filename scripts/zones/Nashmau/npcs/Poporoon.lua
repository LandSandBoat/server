-----------------------------------
-- Area: Nashmau
--  NPC: Poporoon
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LEATHER_HIGHBOOTS,   336 },
        { xi.item.LIZARD_LEDELSENS,   3438 },
        { xi.item.STUDDED_BOOTS,     11172 },
        { xi.item.CUIR_HIGHBOOTS,    20532 },
    }

    player:showText(npc, zones[xi.zone.NASHMAU].text.POPOROON_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
