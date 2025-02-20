-----------------------------------
-- Area: Aht Urhfan Whitegate
--  NPC: Malfud
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        936,  16,    -- Rock Salt
        626, 255,    -- Black Pepper
        633,  16,    -- Olive Oil
        4388, 44,    -- Eggplant
        4390, 40,    -- Mithran Tomato
        2213, 12     -- Pine Nuts
    }

    player:showText(npc, ID.text.MALFUD_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
