-----------------------------------
-- Area: Windurst Waters [S]
--  NPC: Ezura-Romazura
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4771, 123750,        -- Scroll of Stone V
        4781, 133110,        -- Scroll of Water V
        4766, 144875,        -- Scroll of Aero V
        4756, 162500,        -- Scroll of Fire V
        4761, 186375,        -- Scroll of Blizzard V
        4893, 168150,        -- Scroll of Stoneja
        4895, 176700,        -- Scroll of Waterja
        4890, 193800,        -- Scroll of Firaja
        4892, 185240,        -- Scroll of Aeroja
        4863, 126000,        -- Scroll of Break
    }

    player:showText(npc, ID.text.EZURAROMAZURA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
