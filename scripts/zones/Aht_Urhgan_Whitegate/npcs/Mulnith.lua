-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Mulnith
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
        { xi.item.ROAST_MUSHROOM,  344, },
        { xi.item.SIS_KEBABI,     2000, }, -- (Requires Astral Candescence)
        { xi.item.BALIK_SIS,      3000, }, -- (Requires Astral Candescence)
    }

    player:showText(npc, ID.text.MULNITH_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
