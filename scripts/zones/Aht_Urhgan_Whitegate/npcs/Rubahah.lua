-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Rubahah
-- TODO: Stock needs to be modified based on
--       status of Astral Candescence
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.EAR_OF_MILLIONCORN,     48, },
        { xi.item.BAG_OF_IMPERIAL_FLOUR,  60, }, -- (Requires Astral Candescence)
        { xi.item.BAG_OF_IMPERIAL_RICE,   68, }, -- (Requires Astral Candescence)
        { xi.item.BAG_OF_COFFEE_BEANS,   316, }, -- (Requires Astral Candescence)
    }

    player:showText(npc, ID.text.RUBAHAH_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
