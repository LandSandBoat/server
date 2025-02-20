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
        4472,   38,    -- Crayfish
        5458, 1200,    -- Yilanbaligi (Requires Astral Candescence)
        5459, 1800,    -- Sazanbaligu (Requires Astral Candescence)
        5460, 4650,    -- Kayabaligi (Requires Astral Candescence)
        5461,  130     -- Alabaligi (Requires Astral Candescence)
    }

    player:showText(npc, ID.text.KULHAMARIYO_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
