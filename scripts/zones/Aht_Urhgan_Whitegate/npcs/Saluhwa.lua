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
        12290,   605,    -- Mapple Shield (Requires Astral Candescence)
        12291,  1815,    -- Elm Shield (Requires Astral Candescence)
        12292,  4980,    -- Mahogany Shield (Requires Astral Candescence)
        12293, 15600,    -- Oak Shield (Requires Astral Candescence)
        12295, 64791     -- Round Shield (Requires Astral Candescence)
    }

    player:showText(npc, ID.text.SALUHWA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
