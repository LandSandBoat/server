-----------------------------------
-- Area: Lower Jeuno
--  NPC: Matoaka
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SILVER_EARRING,  1250 },
        { xi.item.SILVER_RING,     1250 },
        { xi.item.MYTHRIL_EARRING, 4500 },
    }

    player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.GEMS_BY_KSHAMA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
