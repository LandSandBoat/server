-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Kulh Amariyo
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
        { xi.item.CRAYFISH_1,     38, },
        { xi.item.YILANBALIGI,  1200, }, -- (Requires Astral Candescence)
        { xi.item.SAZANBALIGI,  1800, }, -- (Requires Astral Candescence)
        { xi.item.KAYABALIGI,   4650, }, -- (Requires Astral Candescence)
        { xi.item.ALABALIGI,     130, }, -- (Requires Astral Candescence)
    }

    player:showText(npc, ID.text.KULHAMARIYO_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
