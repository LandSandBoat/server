-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Dwago
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LUGWORM,                 9, },
        { xi.item.LITTLE_WORM,             3, },
        { xi.item.PET_FOOD_ALPHA_BISCUIT, 11, },
        { xi.item.PET_FOOD_BETA_BISCUIT,  82, },
        { xi.item.JUG_OF_BUG_BROTH,       98, },
    }

    player:showText(npc, ID.text.DWAGO_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
