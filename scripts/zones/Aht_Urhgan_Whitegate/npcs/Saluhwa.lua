-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Saluhwa
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
        { xi.item.MAPLE_SHIELD,      605, }, -- (Requires Astral Candescence)
        { xi.item.ELM_SHIELD,       1815, }, -- (Requires Astral Candescence)
        { xi.item.MAHOGANY_SHIELD,  4980, }, -- (Requires Astral Candescence)
        { xi.item.OAK_SHIELD,      15600, }, -- (Requires Astral Candescence)
        { xi.item.ROUND_SHIELD,    64791, }, -- (Requires Astral Candescence)
    }

    player:showText(npc, ID.text.SALUHWA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
