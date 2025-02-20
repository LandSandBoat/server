-----------------------------------
-- Area: Lower Jeuno
--  NPC: Chenokih
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        12850, 24500, -- Hose
        12866, 22632, -- Linen Slacks
        12851, 57600, -- Wool Hose
        12858, 14756, -- Wool Slops
        12865,  6348, -- Black Slacks
        12978, 16000, -- Socks
        12994, 14352, -- Shoes
        12979, 35200, -- Wool Socks
        12986,  9180, -- Chestnut Sabots
        12993,  4128, -- Sandals
        13577, 11088, -- Black Cape
        13568,  1250, -- Scarlet Ribbon
    }

    player:showText(npc, ID.text.ORTHONS_GARMENT_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
